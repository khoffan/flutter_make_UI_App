import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  void saveUserData(String? name, String? email , String? content, String? locate) {

    String? currentTime = DateFormat("dd-mm-yyy").format(DateTime.now());
    // The data you want to save
    Map<String, dynamic> userData = {
      'username': name,
      'email': email,
      'content': content, 
      'locate': locate,
      'date': currentTime,
      // Add any other data you want to save.
    };
    contentController.clear();
    locateController.clear();
    // Save the data
    databaseRef?.set(userData).then((val) {
      print("Data successfully saved!");

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
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          else if (snapshot.hasData) {
            DocumentSnapshot? document = snapshot.data;
            Map<String, dynamic> data = document?.data() as Map<String, dynamic>;


            String? name = data["name"];
            String? email = data["email"];
            return Scaffold(
              appBar: AppBar(title: Text("Add Content"),),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String content = contentController.text;
                            String locate = locateController.text;


                            saveUserData(name, email, content, locate);
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

// import 'package:client_app/models/info.dart';
// import 'package:client_app/providers/info_provider.dart';
// import 'package:client_app/screen/information.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Infomation'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => RequestScreen(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: Consumer<InfoProvider>(builder: (context, provider, child) {
//           var infomationsList = provider.infomations ?? [];
//           var count = infomationsList.length;
//           List<Infomations> infomationList = provider.getInfomations();
//           if (count <= 0) {
//             return Center(
//               child: Text("No information"),
//             );
//           } else {
//             return Container(
//               width: double.infinity,
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//               alignment: Alignment.center,
//               child: ListView.builder(
//                 itemCount: count,
//                 itemBuilder: (context, int index) {
//                   Infomations data = infomationList[index];
//                   return SizedBox(
//                     width: double.infinity,
//                     height: 100,
//                     child: Card(
//                       elevation: 4,
//                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           radius: 50,
//                           child: FittedBox(
//                             child: Text(data.amount.toString()),
//                           ),
//                         ),
//                         title: Text(
//                           data.name ?? '',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               data.description ?? '',
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 18),
//                             ),
//                             Text(
//                               DateFormat("dd-MM-yyyy").format(
//                                 data.date ?? DateTime.now(),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Icon(Icons.library_add),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         }));
//   }
// }
