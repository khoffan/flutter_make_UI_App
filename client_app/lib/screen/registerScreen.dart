import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

import '../models/register.dart';
import '../providers/user_provider.dart';
// import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  UserProfile register = UserProfile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController curpassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text("Error")),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(15),
                                    fillColor: Colors.black,
                                    hintText: "Name",
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  onSaved: (val) {
                                    register.name = val.toString();
                                  },
                                  controller: nameController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "please enter your email"),
                                  ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(15),
                                    fillColor: Colors.black,
                                    hintText: "Email",
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  onSaved: (val) {
                                    register.email = val.toString();
                                  },
                                  controller: emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please enter your email"),
                                    EmailValidator(
                                        errorText: "Invalid email format"),
                                  ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(15),
                                    fillColor: Colors.black,
                                    hintText: "Password",
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  onSaved: (val) {
                                    register.password = val.toString();
                                  },
                                  controller: passController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter tour password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "CurrentPassword",
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(15),
                                    fillColor: Colors.black,
                                    hintText: "CurrentPassword",
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  controller: curpassController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter tour password";
                                    } else if (value != passController.text) {
                                      return 'password not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Phone",
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(15),
                                    fillColor: Colors.black,
                                    hintText: "Phone",
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  onSaved: (val) {
                                    register.phone = val.toString();
                                  },
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter tour password";
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState?.save();
                                    await Users.setLogin(true);
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: register.email.toString(),
                                              password:
                                                  register.password.toString())
                                          .then((value) {
                                        Fluttertoast.showToast(
                                          msg: "Sing-Up complete!",
                                          gravity: ToastGravity.CENTER,
                                        );
                                        _formKey.currentState?.reset();
                                        Navigator.of(context).pop();
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                        msg: e.message.toString(),
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }
                                  }
                                },
                                child: Text("Sign-Up"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
