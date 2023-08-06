import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UI/add_content.dart';
import '../UI/update_contents.dart';

class HomeResponder extends StatefulWidget {
  const HomeResponder({super.key});

  @override
  State<HomeResponder> createState() => _HomeResponderState();
}

class _HomeResponderState extends State<HomeResponder> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _contentsCollection;
  late StreamSubscription<QuerySnapshot> _valueSubscription;
  List<QueryDocumentSnapshot> dataList = [];

  @override
  void initState() {
    super.initState();
    _contentsCollection = _firestore.collection('contents');
    fetchContents();
  }

  void fetchContents() async {
    _valueSubscription = _contentsCollection
        .doc(_auth.currentUser?.uid) // Use the user's uid as the document ID
        .collection('userContents')
        .where('uid',
            isEqualTo:
                'OTHER_USER_UID') // Replace with the UID of the other user
        .orderBy('date', descending: true)
        .limit(50)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        dataList = querySnapshot.docs;
      });
    });
  }

  @override
  void dispose() {
    _valueSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Contents"),
      ),
      body: Container(
        child: dataList.isEmpty
            ? Center(
                child: Text("No content on this page"),
              )
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot snapshot = dataList[index];
                  Map<String, dynamic> usermap =
                      snapshot.data() as Map<String, dynamic>;

                  return showDetail(usermap: usermap, documentId: snapshot.id);
                },
              ),
      ),
    );
  }

  Widget showDetail(
      {required Map<String, dynamic> usermap, required String documentId}) {
    final String content = usermap['content'] ?? '';
    final String locate = usermap['locate'] ?? '';
    final String name = usermap['name'] ?? '';
    final String date = usermap['date'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.amber[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    locate,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    name,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateContent(
                          datas: usermap,
                          documentId: documentId,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    _contentsCollection.doc(documentId).delete();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
