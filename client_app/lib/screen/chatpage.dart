import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatefulWidget {
  final String reciveUserEmail;
  final String reciveUseruid;
  const ChatPage({
    required this.reciveUserEmail,
    required this.reciveUseruid,
    Key? key,
  }) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DatabaseReference _messageRef;
  late types.User _user;
  late StreamSubscription _messageSubscription;
  List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeUserAndChat();
  }

  Future<void> _initializeUserAndChat() async {
    final user = _auth.currentUser;

    if (user == null) {
      // Handle the case when the user is not logged in
      return;
    }

    final userId = user.uid;
    final otherUid = widget.reciveUseruid;

    final chatId = [userId, otherUid].toList()..sort();

    final String? uniqueUserId = Uuid().v4();
    _user = types.User(
      id: uniqueUserId ?? '',
    );

    _messageRef =
        FirebaseDatabase.instance.ref().child('chats').child(chatId.join('_'));
    _messageRef.onChildAdded.listen((event) {
      final value = event.snapshot.value;
      if (value != null && value is Map) {
        final message = types.TextMessage(
          author: types.User(id: value['author']['id']),
          createdAt: value['createdAt'],
          id: value['id'],
          text: value['text'],
        );
        _addMessage(message);
      }
    });
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.add(message);
    });
  }

  @override
  void dispose() {
    // Dispose of the Firebase Realtime Database listener here
    _messageSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciveUserEmail),
      ),
      body: Container(
        child: _messages.isEmpty
            ? Center(
                child: Chat(
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  user: _user,
                ),
              )
            : Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Replace this with the desired height
                child: ListView.builder(
                  reverse:
                      true, // Reverse the list to show latest messages at the bottom
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    if (message is types.TextMessage) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Chat(
                          messages: [message],
                          onSendPressed: _handleSendPressed,
                          user: _user,
                        ),
                      );
                    }
                  },
                ),
              ),
      ),
      // body: ListView.builder(
      //   reverse: true, // Reverse the list to show latest messages at the bottom
      //   itemCount: _messages.length,
      //   itemBuilder: (context, index) {
      //     final message = _messages[index];
      //     return Chat(
      //       messages: _messages,
      //       onSendPressed: _handleSendPressed,
      //       user: _user,
      //     );
      //   },
      // ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _messageRef.push().key!,
      text: message.text,
    );

    _messageRef.child(textMessage.id).set({
      'author': {
        'id': textMessage.author.id,
      },
      'createdAt': textMessage.createdAt,
      'id': textMessage.id,
      'text': textMessage.text,
    });

    _addMessage(textMessage);
  }
}
