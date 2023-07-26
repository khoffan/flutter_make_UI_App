import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class AddProfile {

  Future<String> uploadImagetoStorage(String folder, Uint8List file) async {
    try {
      Reference ref = _storage.ref().child(folder).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      throw e;
    }
  }
  Future<String> saveProfile(
      {required String name,
      required String bio,
      required Uint8List file}) async {
    String resp = "some Error";
    try {
      print("Attempting to save data...");
      if (name.isNotEmpty && bio.isNotEmpty) {
        String imageURL = await uploadImagetoStorage('profileImage', file);

        await _firestore.collection("userProfile").doc(_auth.currentUser!.uid).set({
          'name': name,
          'bio': bio,
          'imageLink': imageURL,
        });
        print("Data saved successfully!");
        resp = "Success";
      } else {
        print("name or bio is empty");
      }
    } catch (e) {
      resp = e.toString();
    }

    return resp;
  }
}