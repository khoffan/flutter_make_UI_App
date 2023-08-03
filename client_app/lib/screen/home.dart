import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../UI/add_content.dart';
import '../UI/btnavigate.dart';
import '../UI/update_contents.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Query refQ; // Declare refQ as a late variable
  DatabaseReference? refdb;

  List<Map> dataList = [];

  @override
  void initState() {
    super.initState();
    refQ = FirebaseDatabase.instance
        .ref()
        .child('contents')
        .child(_auth.currentUser?.uid ?? '')
        .orderByChild('date')
        .limitToLast(50);

    refQ.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map values = event.snapshot.value as Map;
        List<Map> tempList = values.values.toList().cast<Map>();
        tempList.sort((a, b) => b['date']
            .compareTo(a['date'])); // Sort in descending order based on 'date'
        setState(() {
          dataList = tempList;
        }); // Trigger a rebuild after data is fetched and sorted
      }
    });

    refdb = FirebaseDatabase.instance
        .ref()
        .child('contents')
        .child(_auth.currentUser?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list Contents"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddContent()));
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Container(
        child: dataList.isEmpty
            ? Center(
                child: Text("no content on this page"),
              )
            : Column(
                children: [
                  Flexible(
                    child: FirebaseAnimatedList(
                      query: refQ,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        if (snapshot.value == null) {
                          return Container(); // Return an empty container if the value is null
                        }

                        dynamic value = snapshot.value;
                        if (value is Map) {
                          // If the value is already a Map, use it directly
                          value['key'] = snapshot.key ??
                              ''; // Get the key from the snapshot
                        } else if (value is String) {
                          // If the value is a String, decode it using json.decode()
                          Map<String, dynamic> decodedValue =
                              json.decode(value);
                          if (decodedValue is Map) {
                            value = decodedValue;
                            value['key'] = snapshot.key ??
                                ''; // Get the key from the snapshot
                          } else {
                            // Handle the case where the decoded value is not a Map (if needed)
                            return Container();
                          }
                        } else {
                          // Handle other data types if needed
                          return Container();
                        }

                        return showDetail(usermap: value);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget showDetail({required Map usermap}) {
    final String content = usermap['content'] ?? '';
    final String locate = usermap['locate'] ?? '';
    final String name = usermap['name'] ?? '';
    final String date = usermap['date'] ?? '';
    final String keyDb = usermap['key'] ?? '';

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
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    refdb?.child(keyDb).remove();
                    print("remove: " + keyDb);
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
