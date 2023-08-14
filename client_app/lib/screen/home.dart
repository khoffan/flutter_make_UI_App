import 'package:client_app/providers/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:intl/intl.dart';

import '../UI/add_content.dart';
import '../UI/update_contents.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content List rider'),
      ),
      body: ContentList(),
    );
  }
}

class ContentList extends StatelessWidget {
  final ContentService _service = ContentService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void removeContent(String uid, String docid) {
    // FirebaseFirestore.instance
    //     .collection('contents')
    //     .doc(uid)
    //     .collection('contentUser')
    //     .doc(docid)
    //     .delete();
    _service.removeContent(uid, docid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _service.getContentListStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final contentDocs = snapshot.data!.docs;
        // if (contentDocs.isEmpty) {
        //   return Center(
        //     child: Text('No content'),
        //   );
        // }

        return ListView.builder(
          itemCount: contentDocs.length,
          itemBuilder: (context, index) {
            final contentDoc = contentDocs[index];
            final contentUserCollection =
                contentDoc.reference.collection('contentUser');
            return StreamBuilder<QuerySnapshot>(
              stream: contentUserCollection.snapshots(),
              builder: (context, contentUserSnapshot) {
                if (contentUserSnapshot.hasError) {
                  return ListTile(
                      title: Text('Error: ${contentUserSnapshot.error}'));
                }

                if (!contentUserSnapshot.hasData) {
                  return ListTile(title: Text('Loading...'));
                }

                final contentUserDocs = contentUserSnapshot.data!.docs;
                if (_auth.currentUser!.uid != contentDoc.id) {
                  final status = contentDoc['status'] as bool;
                  print("status ${status}");
                  if (status != true && contentUserDocs.isNotEmpty) {
                    print('uid ${_auth.currentUser!.uid}');
                    return ListView.builder(
                      itemCount: contentUserDocs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, userIndex) {
                        final contentUserData = contentUserDocs[userIndex]
                            .data() as Map<String, dynamic>;
                        final content = contentUserData['contents'] as String;
                        final locate = contentUserData['locate'] as String;
                        final name = contentUserData['name'] as String;
                        final date = contentUserData['date'] as Timestamp;
                        final dateTime = date.toDate();
                        final formattedDate =
                            DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

                        final contentUserDocId = contentUserDocs[userIndex].id;
                        final contentDocId = contentDoc.id;

                        return Card(
                          elevation: 2,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Column(
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(content),
                                    Text(locate),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(name),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(formattedDate),
                                  ],
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('comment'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      alignment: Alignment.center,
                      child: Text('No content'),
                    );
                  }
                } else {
                  return Container();
                }
              },
            );
          },
        );
      },
    );
  }
}
