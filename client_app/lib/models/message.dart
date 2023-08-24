// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? senderId;
  final String? senderEmail;
  final String? reciveId;
  final String? message;
  final String? imageLink;
  final Timestamp timeStemp;

  Messages({
    required this.senderId,
    required this.senderEmail,
    required this.reciveId,
    this.message,
    this.imageLink,
    required this.timeStemp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'reciveId': reciveId,
      'message': message,
      'imageLink': imageLink,
      'timeStemp': timeStemp,
    };
  }
}
