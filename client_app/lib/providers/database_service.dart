import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData(String uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection('contents').doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      return {};
    }
  }

  Future<void> saveUserData({
    required String uid,
    required String name,
    required String email,
    required String content,
    required String locate,
  }) async {
    String currentTime = DateFormat("dd-MM-yyyy H:m:s").format(DateTime.now());

    Map<String, dynamic> userData = {
      'uid': uid,
      'name': name,
      'email': email,
      'content': content,
      'locate': locate,
      'date': currentTime,
      // Add any other data you want to save.
    };

    await firestore
        .collection('contents')
        .doc(uid)
        .collection('userContents')
        .add(userData);
    print("Data successfully saved!");
  }

  Future<void> updateUserData({
    required String uid,
    required String docId,
    required String content,
    required String locate,
  }) async {
    await firestore
        .collection('contents')
        .doc(uid)
        .collection('userContents')
        .doc(docId)
        .update({
      'content': content,
      'locate': locate,
    });

    print("Data successfully updated!");
  }

  Future<void> removeUserData({
    required String uid,
    required String docId,
  }) async {
    await firestore
        .collection('contents')
        .doc(uid)
        .collection('userContents')
        .doc(docId)
        .delete();

    print("Data successfully removed!");
  }
}
