// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? senderId;
  final String? senderEmail;
  final String? reciveId;
  final String? message;
  final Timestamp timeStemp;

  Messages({
    required this.senderId,
    required this.senderEmail,
    required this.reciveId,
    required this.message,
    required this.timeStemp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'reciveId': reciveId,
      'message': message,
      'timeStemp': timeStemp,
    };
  }
}
