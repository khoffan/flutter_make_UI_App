import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'homeResponder.dart';
import 'showUser.dart';

class LoadingScreen extends StatefulWidget {
  final String uid;

  LoadingScreen({required this.uid});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasData) {
              DocumentSnapshot? document = snapshot.data;
              Map<String, dynamic>? data =
                  document?.data() as Map<String, dynamic>;

              bool? status = data['status'];
              if (status == true) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Myhome()),
                  );
                });
                print(status);
              } else if (status == false) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => HomeResponder(),
                    ),
                  );
                });
                print(status);
              }
            }
            return Container();
          }),
    );
  }
}
