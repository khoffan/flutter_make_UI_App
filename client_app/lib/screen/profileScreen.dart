import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';

import 'package:client_app/providers/auth_user.dart';
import 'package:client_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/utils.dart';
import 'edirProfile.dart';
import 'loginscreen.dart';

class ProfileScreenApp extends StatefulWidget {
  const ProfileScreenApp({super.key});

  @override
  State<ProfileScreenApp> createState() => _ProfileScreenAppState();
}

class _ProfileScreenAppState extends State<ProfileScreenApp> {
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickerImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              showMediabottom(context);
            },
            icon: Icon(Icons.dehaze),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('assets/personal.png')
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 28,
                      ),
                    ),
                    bottom: -10,
                    left: 80,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(children: [Text("Name"), Text("company")]),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                      
                    },
                    child: Text("Edit profile"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showMediabottom(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildContentMedia(context, "change password"),
                  buildContentMedia(context, "About me"),
                  buildContentMedia(context, "Delete Account"),
                  buildContentMedia(context, "somthing else"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Users.setLogin(false);
                          await AuthUsers().signOut(context);
                          
                          
                          
                        },
                        child: Text("Sign Out"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector buildContentMedia(context, String title) {
    if (title == "change password") {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.key)),
            TextButton(
              onPressed: () {},
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 56, 56, 56)),
              ),
            ),
          ]),
        ),
      );
    } else if (title == "About me") {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.person_2)),
            TextButton(
              onPressed: () {},
              child: Text(title,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 56, 56, 56))),
            ),
          ]),
        ),
      );
    } else if (title == "Delete Account") {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Colors.red,
                )),
            TextButton(
              onPressed: () {},
              child: Text(
                title,
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            )
          ]),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {},
        child: SizedBox(),
      );
    }
  }
}
