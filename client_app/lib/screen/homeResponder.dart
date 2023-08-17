import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../UI/add_content.dart';
import '../UI/update_contents.dart';

class ContentPageRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content List Rider'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddContentPage(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ContentList(),
    );
  }
}

class ContentList extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void removeContent(String uid, String docid) {
    FirebaseFirestore.instance
        .collection('contents')
        .doc(uid)
        .collection('contentUser')
        .doc(docid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final specificPersonUid = _auth.currentUser?.uid ?? '';
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('contents').snapshots(),
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
                contentDoc.id ==
                specificPersonUid) // Filter content for specific person
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

                if (contentUserDocs.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    alignment: Alignment.center,
                    child: Text('No content'),
                  );
                }

                return ListView.builder(
                  itemCount: contentUserDocs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, userIndex) {
                    final contentUserData = contentUserDocs[userIndex].data()
                        as Map<String, dynamic>;
                    final content = contentUserData['contents'] as String;
                    final locate = contentUserData['locate'] as String;
                    final name = contentUserData['name'] as String;
                    final date = contentUserData['date'] as Timestamp;
                    final dateTime = date.toDate();
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                    final contentUserDocId = contentUserDocs[userIndex].id;
                    final contentDocId = contentDoc.id;
                    print(contentUserDocId);
                    print(contentDocId);
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(name),
                                Text(formattedDate),
                              ],
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UpdateContentPage(
                                        contentDocId: contentDocId,
                                        contentUserDocId: contentUserDocId,
                                        initialText: content,
                                        initialTitle: locate,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Update'),
                              ),
                              TextButton(
                                onPressed: () {
                                  removeContent(contentDocId, contentUserDocId);
                                },
                                child: Text('Remove'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
