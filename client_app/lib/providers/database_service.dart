import 'package:cloud_firestore/cloud_firestore.dart';

class ContentService {
   Stream<QuerySnapshot> getContentListStream() {
    return FirebaseFirestore.instance.collection('contents').snapshots();
  }

  Future<void> updateContent(String uid, String docid, Map<String, dynamic> data) async {
    // Update content document in Firestore
    try {
      await FirebaseFirestore.instance
          .collection('contents')
          .doc(uid)
          .collection('contentUser')
          .doc(docid)
          .update(data);
    } catch (e) {
      throw e.toString();
    }
  }
  Future<void> updateContentStatus(String uid, bool newStatus) async {
    // Update content document in Firestore
    try {
      await FirebaseFirestore.instance
          .collection('contents')
          .doc(uid)
          .update({'status': newStatus});
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeContent(String uid, String docid) async {
    // Remove content document from Firestore
    try {
      await FirebaseFirestore.instance
          .collection('contents')
          .doc(uid)
          .collection('contentUser')
          .doc(docid)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveContent(String uid, Map<String, dynamic> contentData) async {
    // Save new content document to Firestore
    try {
      await FirebaseFirestore.instance
          .collection('contents')
          .doc(uid)
          .collection('contentUser')
          .add(contentData);
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<QuerySnapshot> getContentListStreamWithStatus() {
    return FirebaseFirestore.instance
        .collection('contents')
        .orderBy('status', descending: true) // Adjust sorting as needed
        .snapshots();
  }

  getContentList() {}
}
