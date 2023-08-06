import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/database_service.dart';

class AddContent extends StatefulWidget {
  const AddContent({Key? key}) : super(key: key);

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late User user;
  late String userUID;

  final formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController locateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    userUID = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Content"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fireStore.collection('Users').doc(userUID).get(),
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
            Map<String, dynamic> data = document?.data() as Map<String, dynamic>;

            String uidUser = data["uid"];
            String nameUser = data["name"];
            String emailUser = data["email"];
            
            return Container(
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
                            return "Please enter your content";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Locate"),
                          hintText: "Enter your Locate",
                        ),
                        controller: locateController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your locate";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            String content = contentController.text;
                            String locate = locateController.text;
                            DatabaseService().saveUserData(
                              uid: uidUser,
                              name: nameUser,
                              email: emailUser,
                              content: content,
                              locate: locate,
                            );
                            contentController.clear();
                            locateController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SafeArea(
            child: Container(
              child: Text("Data not found"),
            ),
          );
        },
      ),
    );
  }
}
