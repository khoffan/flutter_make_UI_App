
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import '../providers/user_provider.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController curpass = TextEditingController();

  Future SignupConnect() async {
    String url = "http://172.22.118.252/api_flutter/register.php";
    final res = await http.post(Uri.parse(url), body: {
      "name": name.text,
      "email": email.text,
      "password": pass.text,
    });
    // var responseEncoding = res.headers['content-type']?.split('charset=')[1];
    try {
      var data = json.decode(res.body);
      print(data);
      if (data == "Error") {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RegisterScreen()));
        
      } else {
        await Users.setLogin(true);
         Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ]),
            height: 50,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 26),
                prefixIcon: Icon(
                  Icons.person,
                ),
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              controller: name,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildLastname() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lastname',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 60,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 26),
                prefixIcon: Icon(
                  Icons.person_2,
                ),
                hintText: "Lastname",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              controller: lastname,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter your Lastname";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 60,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 26),
                prefixIcon: Icon(
                  Icons.mail,
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              controller: email,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter your Email";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildPassword(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 60,
            child: TextFormField(
              obscureText: obscureText,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 26),
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              controller: pass,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildCurrpass() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CurrentPassword',
              style: TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ]),
            height: 60,
            child: TextFormField(
              obscureText: obscureText,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 26),
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
                hintText: "CurrentPassword",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              controller: curpass,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter your password";
                } else if (val != pass.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  // Widget buildSignbtn(BuildContext context) {
  //   final _formKey = GlobalKey<FormState>();
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
  //     width: double.infinity,
  //     child: TextButton(
  //       onPressed: () {
  //         if(_formKey.currentState?.validate() ?? false){
  //           var n = name.text;
  //           var lname = lastname.text;
  //           var e = email.text;
  //           var p = pass.text;

  //           print(n);
  //           print(lname);
  //           print(e);
  //           print(p);
  //           Navigator.of(context).pop();
  //         }
  //       },
  //       style: TextButton.styleFrom(
  //         backgroundColor: Colors.blue,
  //       ),
  //       child: Text(
  //         "SignUp",
  //         style: TextStyle(color: Colors.black, fontSize: 20),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 30, color: Colors.black),
              )),
              SizedBox(
                height: 20,
              ),
              buildName(),
              buildLastname(),
              buildEmail(),
              buildPassword(context),
              buildCurrpass(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      SignupConnect();
                      // Navigator.of(context).pop();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "SignUp",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
