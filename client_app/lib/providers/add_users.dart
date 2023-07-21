import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddUsers {
  Future<String> saveUsers(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    String resp = "some Error";
    try {
      print("Attempting to save data...");
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && phone.isNotEmpty) {

        String hashPw = BCrypt.hashpw(password, BCrypt.gensalt());
        await _firestore.collection("Users").add({
          'name': name,
          'email': email,
          'phone': phone,
          'password':hashPw
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