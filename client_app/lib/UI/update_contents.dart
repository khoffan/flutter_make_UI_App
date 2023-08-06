import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/database_service.dart';
import '../screen/home.dart';
import 'btnavigate.dart';

class UpdateContent extends StatefulWidget {
  const UpdateContent(
      {super.key, required this.datas, required this.documentId});
  final Map datas;
  final String documentId;
  @override
  State<UpdateContent> createState() => _UpdateContentState();
}

class _UpdateContentState extends State<UpdateContent> {
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

    // Make sure user is not null before retrieving UID
    if (_auth?.currentUser != null) {
      userUID = _auth?.currentUser?.uid;
    }

    getData();
  }

  void getData() {
    contentController.text = widget.datas['content'];
    locateController.text = widget.datas['locate'];
  }

  void saveUserData(
      String? name, String? email, String? content, String? locate) async {
    if (userUID != null) {
      // Check if userUID is not null
      String currentTime = DateFormat("dd-MM-yyyy").format(DateTime.now());

      await DatabaseService().updateUserData(
        uid: userUID ?? '',
        docId: widget.documentId ?? '', // Assuming 'key' is the document ID
        content: content ?? '',
        locate: locate ?? '',
      );

      contentController.clear();
      locateController.clear();

      print("Data successfully updated!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BottomNavigationBarAppRequester(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _fireStore?.collection('Users').doc(widget.documentId).get(),
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
            // DocumentSnapshot? document = snapshot.data;
            // Map<String, dynamic> data = document?.data() as Map<String, dynamic>;

            String? name = widget.datas['name'];
            String? email = widget.datas['email'];
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
