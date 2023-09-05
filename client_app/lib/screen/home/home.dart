import 'package:client_app/providers/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../UI/add_content.dart';
import '../../UI/comments.dart';
import '../../UI/update_contents.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content List'),
      ),
      body: ContentList(),
    );
  }
}

final _fromkey = GlobalKey<FormState>();
TextEditingController _commentController = TextEditingController();

class ContentList extends StatelessWidget {
  final ContentService _service = ContentService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void saveComment(String uid, String docid, String name) async {
    try {
      String comment = _commentController.text;
      if (comment.isEmpty) {
        return;
      }
      final contentData = {
        'name': name,
        'comment': comment,
        'contentid': docid,
        'date': Timestamp.now(),
      };

      await ContentService().saveContentComment(uid, contentData);
      _commentController.clear();
      print('save comments success');
    } catch (e) {
      throw e.toString();
    }
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

        final filteredContentDocs = contentDocs
            .where((contentDoc) =>
                contentDoc["status"] ==
                false) // Filter content for specific person
            .toList();

        if (filteredContentDocs.isEmpty) {
          return Center(child: Text('No content for this person.'));
        }
        return ListView.builder(
          itemCount: filteredContentDocs.length,
          itemBuilder: (context, index) {
            final contentDoc = filteredContentDocs[index];
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

                final status = contentDoc['status'] as bool;
                // print("content doc id ${contentDoc.id} ");
                // print("status ${status}");
                if (status != true && contentUserDocs.isNotEmpty) {
                  // print('uid ${_auth.currentUser!.uid}');
                  return ListView.builder(
                    itemCount: contentUserDocs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, userIndex) {
                      final contentUserData = contentUserDocs[userIndex].data()
                          as Map<String, dynamic>;
                      final content =
                          contentUserData['contents'] as String ?? '';
                      final locate = contentUserData['locate'] as String ?? '';
                      final name = contentUserData['name'] as String ?? '';
                      final date = contentUserData['date'] as Timestamp;
                      final dateTime = date.toDate();
                      final formattedDate =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime) ??
                              '';

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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('eiei'),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _buildBottomMedia(context, contentDocId,
                                        contentUserDocId, name);
                                  },
                                  child: Text('comment'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (status == true || contentUserDocs.isNotEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    alignment: Alignment.center,
                    child: Text('No content'),
                  );
                }
                return Container();
              },
            );
          },
        );
      },
    );
  }

  Future _buildBottomMedia(context, String uid, String docid, String name) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Form(
            key: _fromkey,
            child: Column(
              children: [
                Expanded(child: Container(
                  child: Comments(uid: uid, docId: docid,),
                )),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'comment',
                          hintText: "comment",
                        ),
                        controller: _commentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a comment";
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_fromkey.currentState!.validate()) {
                          saveComment(uid, docid, name);
                        }
                      },
                      icon: Icon(Icons.send_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
