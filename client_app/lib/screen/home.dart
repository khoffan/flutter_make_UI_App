import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase fireDB = FirebaseDatabase.instance;

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = fireDB.ref().child('contents').child(_auth.currentUser?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DataSnapshot?>(
        future: fireDB.ref().child('contents').child(_auth.currentUser?.uid ?? '').once(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SafeArea(
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            DataSnapshot? dataSnapshot = snapshot.data;
            Map<dynamic, dynamic>? data = dataSnapshot?.data() as Map<dynamic, dynamic>;
            if (data != null) {
              // Display the data here using Text widgets or any other widgets as needed
              return SafeArea(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Username: ${data['name']}'),
                        Text('Email: ${data['email']}'),
                        // Add more Text widgets or widgets to display other data
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return SafeArea(
            child: Container(
              child: Center(
                child: Text("no data in DB"),
              ),
            ),
          );
        },
      ),
    );
  }
}
