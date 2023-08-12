import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../UI/add_content.dart';
import '../UI/update_contents.dart';


class ContentPageRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content List'),
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

                if (contentUserDocs.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height/1.4,
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
                            title: Text(content),
                            subtitle: Text(locate),
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
