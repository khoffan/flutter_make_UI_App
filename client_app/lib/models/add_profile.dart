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
      Reference ref =
          _storage.ref().child(folder).child(DateTime.now().toString());
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
      {required String std,
      required String room,
      required String dorm,
      required Uint8List file}) async {
    String resp = "some Error";
    try {
      print("Attempting to save data...");

      if (std.isNotEmpty && dorm.isNotEmpty && room.isNotEmpty) {
        Map<String, dynamic> userData =
            await getUsers(_auth.currentUser?.uid ?? '');

        String imageURL = await uploadImagetoStorage('profileImage', file);
        String name = userData['name'] ?? '';
        String email = userData['email'] ?? '';

        await _firestore
            .collection("userProfile")
            .doc(_auth.currentUser?.uid ?? '')
            .set({
          'name': name,
          'email': email,
          'stdid': std,
          'dorm': dorm,
          'room': room,
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

  Future<Map<String, dynamic>> getUsers(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Users').doc(uid).get();

      if (snapshot.exists && snapshot != null) {
        Map<String, dynamic> userData = snapshot.data()!;
        return userData;
      } else {
        throw "data not found";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateProfile(
      {required String dorm,
      required String room,
      required String stdId,
      }) async {
    try {
      // String imageURL = await uploadImagetoStorage('profileImage', file);

      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('userProfile').doc(currentUser.uid).update({
          'dorm': dorm,
          'room': room,
          'stdid': stdId,
          
        });
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
