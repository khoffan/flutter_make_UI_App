import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatpage.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Userlist"),
      ),
      body: builderUser(),
    );
  }

  Widget builderUser() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        final document = snapshot.data!.docs;
        return ListView(
          children:
              document.map<Widget>((docs) => _builderItemUser(docs)).toList(),
        );
      },
    );
  }

  Widget _builderItemUser(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
    if (data != null && _auth.currentUser?.email != data['email']) {
      return ListTile(
        title: Text(data['email'] ?? ''), // Use ?? to provide a default value if null
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciveUserEmail: data['email'] ?? '', // Use ?? to provide a default value if null
                reciveUseruid: data['uid'] ?? '', // Use ?? to provide a default value if null
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
