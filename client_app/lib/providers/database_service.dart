import 'package:cloud_firestore/cloud_firestore.dart';

class ContentService {
  Stream<QuerySnapshot> getContentListStream() {
    return FirebaseFirestore.instance.collection('contents').snapshots();
  }

  Future<void> updateContent(
      String uid, String docid, Map<String, dynamic> data) async {
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
      final status = await getStatus(uid);

      await FirebaseFirestore.instance
          .collection('contents')
          .doc(uid)
          .set({
        'status': status, // Add the status field
      });

      final contentDocRef = FirebaseFirestore.instance
          .collection('contents')
          .doc(uid);
      await contentDocRef.collection('contentUser').add(contentData);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> setSataus(bool status, String uid) async {
    try {
      if (uid != null && status != null) {
        await FirebaseFirestore.instance.collection('contents').doc(uid).set({
          'status': status, // Add the status field
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool?> getStatus(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('contents')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return data['status'] as bool?;
      } else {
        return null; // Document not found
      }
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
