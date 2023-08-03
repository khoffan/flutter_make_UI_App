import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screen/home.dart';
import 'btnavigate.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  FirebaseAuth? _auth;
  FirebaseFirestore? _fireStore;
  User? user;
  String? userUID;
  DatabaseReference? databaseRef;

  final formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController locateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
    user = _auth?.currentUser;
    userUID = user?.uid;
    if (userUID != null) {
      databaseRef =
          FirebaseDatabase.instance.ref().child('contents').child(userUID!);
    }
  }

  void saveUserData(
      String? name, String? email, String? content, String? locate) {
    String? currentTime = DateFormat("dd-MM-yyy H:m:s").format(DateTime.now());
    // The data you want to save
    Map<String, dynamic> userData = {
      'name': name ?? '',
      'email': email ?? '',
      'content': content ?? '',
      'locate': locate ?? '',
      'date': currentTime,
      // Add any other data you want to save.
    };
    contentController.clear();
    locateController.clear();
    // Save the data
    DatabaseReference? newRef = databaseRef?.push();
    newRef?.set(userData).then((val) {
      String newKey = newRef.key ?? '';
      print("Data successfully saved! $newKey");
      Navigator.pop(context);
    }).catchError((error) {
      print("Error saving data: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _fireStore?.collection('Users').doc(userUID).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SafeArea(
              child: Container(
                child: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            DocumentSnapshot? document = snapshot.data;
            Map<String, dynamic> data =
                document?.data() as Map<String, dynamic>;

            String? name = data["name"];
            String? email = data["email"];
            return Scaffold(
              appBar: AppBar(
                title: Text("Add Content"),
              ),
              body: Container(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Content"),
                            hintText: "Enter your content",
                          ),
                          controller: contentController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please your enter content";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Locate"),
                            hintText: "Enter your Locate",
                          ),
                          controller: locateController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please your enter locate";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              String content = contentController.text;
                              String locate = locateController.text;
                              saveUserData(name, email, content, locate);
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SafeArea(
            child: Container(
              child: Text("data not found"),
            ),
          );
        },
      ),
    );
  }
}
