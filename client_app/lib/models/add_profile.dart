import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddProfile {
<<<<<<< HEAD
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
=======
  Future<String> uploadImagetoStorage(String name, Uint8List file) async {
    Reference ref = _storage.ref().child(name);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String dowloadURL = await snapshot.ref.getDownloadURL();
    return dowloadURL;
>>>>>>> f4157e832f4e6be38701fb423e7b86ea267c6b5b
  }

  Future<String> saveProfile(
      {required String name,
      required String bio,
      required Uint8List file}) async {
    String resp = "some Error";
    try {
      print("Attempting to save data...");
<<<<<<< HEAD
      if (name.isNotEmpty && bio.isNotEmpty) {
=======
      if (name.isNotEmpty && bio.isNotEmpty && file != null) {
>>>>>>> f4157e832f4e6be38701fb423e7b86ea267c6b5b
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
