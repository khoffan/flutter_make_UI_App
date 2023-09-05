import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  Comments({super.key, required this.uid, required this.docId});

  String uid = "";
  String docId = "";

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('contents')
          .doc(widget.uid)
          .collection('comments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final contentDocs = snapshot.data!.docs;

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: contentDocs.length,
            itemBuilder: (context, index) {
              final contentDoc = contentDocs[index];
              final commentData = contentDoc.data() as Map<String, dynamic>;
              final comment = commentData['comment'];
              final commentid = commentData['contentid'];
              if (commentid == widget.docId) {
                return ListTile(
                  title: Text(comment),
                );
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
