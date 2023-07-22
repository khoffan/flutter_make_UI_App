// import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
import '../UI/btnavigate.dart';
// import '../providers/user_provider.dart';
import '../models/register.dart';
import '../providers/auth_user.dart';
import '../providers/user_provider.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  UserProfile login = UserProfile();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
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
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  //make felid input text
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
                                  onSaved: (val) =>
                                      login.email = val.toString(),
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email';
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: EdgeInsets.all(15),
                                  fillColor: Colors.black,
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                                onSaved: (val) {
                                  login.password = val.toString();
                                },
                                controller: passwordController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Container(
                                child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        formKey.currentState?.save();
                                        await Users.setLogin(true);
                                        try {
                                          await AuthUsers().signInwithEmailpassword(
                                            emailController.text,
                                            passwordController.text
                                          ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => BottomNavigationBarAppRequester())));
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                            msg: e.message.toString(),
                                            gravity: ToastGravity.CENTER,
                                          );
                                        }
                                      }
                                    },
                                    child: Text("Login"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("if you don't have account? "),
                          TextButton(
                            child: Text(
                              "sign-up",
                              style: TextStyle(color: Colors.red),
                            ),
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                          ),
                        ],
                      ),
                    ],
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
