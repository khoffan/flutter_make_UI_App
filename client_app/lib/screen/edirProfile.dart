import 'dart:typed_data';



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/utils.dart';
import '../models/add_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  TextEditingController dormController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController stdController = TextEditingController();

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickerImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveFile(String std, String drom, String room) async {
    if(_image == null){
      return;
    }

    await AddProfile().saveProfile(std: std, room: room, file: _image!, dorm: drom);
    dormController.clear();
    roomController.clear();
    stdController.clear();
    Navigator.of(context)
        .pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("${snap.error}")),
          );
        } else if (snap.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  backgroundImage: NetworkImage(
                                      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fw7.pngwing.com%2Fpngs%2F205%2F731%2Fpng-transparent-default-avatar-thumbnail.png&tbnid=vj1POnmqwlZL-M&vet=12ahUKEwiv1vzRpZqAAxX-0qACHdgLBcgQMygCegUIARDlAQ..i&imgrefurl=https%3A%2F%2Fwww.pngwing.com%2Fen%2Fsearch%3Fq%3Ddefault&docid=J354HYBi_egj6M&w=360&h=360&q=default%20avatar%20in%20png&hl=en&ved=2ahUKEwiv1vzRpZqAAxX-0qACHdgLBcgQMygCegUIARDlAQ'),
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
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(children: [
                          buildFeildInput(context,"student-id"),
                          buildFeildInput(context,"dorm"),
                          buildFeildInput(context,"room"),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                String dorm = dormController.text;
                                String std = stdController.text;
                                String room = roomController.text;

                                saveFile(std, room,dorm);

                                _formKey.currentState?.reset();
                              }
                            },
                            child: Text("Save profile"),
                          ),
                        ),
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
      },
    );
  }

  GestureDetector buildFeildInput(context, String title) {
    if(title == "student-id"){
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: title),
            controller: stdController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "please enter your name";
              }
              return null;
            },
          ),
        ),
      );
    }
    if (title == "dorm") {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: title),
            controller: dormController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "please enter your name";
              }
              return null;
            },
          ),
        ),
      );
    }
    if(title == "room"){
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: title),
            controller: roomController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "please enter your name";
              }
              return null;
            },
          ),
        ),
      );
    }
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text("Error show widget"),
        ),
      ),
    );
  }
}
