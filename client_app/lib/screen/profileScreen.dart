// import 'dart:typed_data';
import 'dart:async';
import 'dart:typed_data';

import 'package:client_app/models/utils.dart';
import 'package:client_app/providers/auth_user.dart';
import 'package:client_app/providers/database_service.dart';
import 'package:client_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../UI/edirProfile.dart';
import '../UI/update_profile.dart';

class ProfileScreenApp extends StatefulWidget {
  const ProfileScreenApp({super.key});

  @override
  State<ProfileScreenApp> createState() => _ProfileScreenAppState();
}

class _ProfileScreenAppState extends State<ProfileScreenApp> {
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Uint8List? _image;
  // void selectImage() async {
  //   Uint8List img = await pickerImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  // }

  final TextStyle optionStyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final User? currentUser = _auth.currentUser;
          if (currentUser == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Null user in db"),
                  ElevatedButton(
                    onPressed: () async {
                      await Users.setLogin(false);
                      await AuthUsers().signOut(context);
                    },
                    child: Text("Sign Out"),
                  ),
                ],
              ),
            );
          }
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("userProfile")
                .doc(currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading....."),
                );
              } else if (snapshot.hasData) {
                var data = snapshot.data?.data();
                String name = data?["name"] ?? '';
                String email = data?["email"] ?? '';
                String std = data?["stdid"] ?? '';
                String room = data?["room"] ?? '';
                String dorm = data?["dorm"] ?? '';
                String image = data?["imageLink"] ?? '';
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue,
                    title: Text("UserProgile"),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                               image.isNotEmpty
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(image),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage: AssetImage('assets/userpersonal.png') // Replace with your placeholder image asset
                                  ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.amber,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "name : " + name.toString(),
                                        style: optionStyle,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "dorm: " + dorm.toString(),
                                        style: optionStyle,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "room: " + room.toString(),
                                        style: optionStyle,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "StudentId: " + std.toString(),
                                        style: optionStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile()),
                                              );
                                            },
                                            child: Text("Edit profile"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProfile(stdid: std, room: room, dorm: dorm,)),
                                              );
                                            },
                                            child: Text("update profile"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          );
        }
        return Container();
      },
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
