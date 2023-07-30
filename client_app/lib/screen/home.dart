import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../UI/add_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Query refQ; // Declare refQ as a late variable

  @override
  void initState() {
    super.initState();
    refQ = FirebaseDatabase.instance
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
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddContent()));
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: FirebaseAnimatedList(
                  query: refQ,
                  itemBuilder: (context, snapshot, animation, index) {
                    Map value = snapshot.value as Map;
                    value['key'] = snapshot.key;
                    return showDetail(usermap: value);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget showDetail({required Map usermap}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(usermap['content']),
                Text(usermap['name']),
                Text(usermap['email']),
                Text(usermap['date']),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Realtime Database Demo'),
//       ),
//       body: (
//         stream: _databaseReference.child('contents').child(_auth.currentUser?.uid ?? '').onValue,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             DataSnapshot? data = snapshot.data?.snapshot;
//             Map<String, dynamic> values = data?.value as Map<String, dynamic>;

//             if(values == null){
//               return Center(child: Text('No data found.'));
//             }
//             List<DataModel> dataList = [];

//             values.forEach((key, value) {
//               DataModel dataModel = DataModel.fromMap(value);
//               dataList.add(dataModel);
//             });

//             return ListView.builder(
//               itemCount: dataList.length,
//               itemBuilder: (context, index) {
//                 DataModel data = dataList[index];
//                 return ListTile(
//                   title: Text(data.name),
//                   subtitle: Text(data.email),
//                   trailing: Text(data.date),
//                   // Customize the UI to display other data fields as needed
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class DataModel {
//   final String name;
//   final String email;
//   final String content;
//   final String date;

//   DataModel({required this.name, required this.email, required this.content, required this.date});

//   factory DataModel.fromMap(Map<dynamic, dynamic> map) {
//     return DataModel(
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       content: map['content'] ?? '',
//       date: map['date'] ?? '',
//     );
//   }
// }
