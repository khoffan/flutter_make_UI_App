import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddProfile {
  Future<String> uploadImagetoStorage(String name, Uint8List file) async {
    Reference ref = _storage.ref().child(name);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String dowloadURL = await snapshot.ref.getDownloadURL();
    return dowloadURL;
  }

  Future<String> saveProfile(
      {required String name,
      required String bio,
      required Uint8List file}) async {
    String resp = "some Error";
    try {
      print("Attempting to save data...");
      if (name.isNotEmpty && bio.isNotEmpty && file != null) {
        String imageURL = await uploadImagetoStorage('profileImage', file);
        await _firestore.collection("userProfile").add({
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
