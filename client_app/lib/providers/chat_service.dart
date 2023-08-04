import 'package:client_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String? receiveid, String? message) async {
    final String? currentId = _auth.currentUser!.uid;
    final String? currentEmail = _auth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    if (currentId != null &&
        currentEmail != null &&
        receiveid != null &&
        message != null) {
      Messages newMessage = Messages(
        senderId: currentId,
        senderEmail: currentEmail,
        reciveId: receiveid,
        message: message,
        timeStemp: timeStamp,
      );

      List<String> ids = [currentId, receiveid];
      ids.sort();
      String chatRoomId = ids.join("_");

      await _fireStore
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    }
  }

  Stream<QuerySnapshot> getMessage(String userid, String otherId) {
      List<String> ids = [userid, otherId];
        ids.sort();
        String chatRoomId = ids.join("_");

        return _fireStore
            .collection('chat_room')
            .doc(chatRoomId)
            .collection('messages')
            .orderBy('timeStemp', descending: false)
            .snapshots();
    }
}
