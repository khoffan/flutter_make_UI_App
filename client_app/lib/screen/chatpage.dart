import 'package:client_app/UI/chat_bouble.dart';
import 'package:client_app/providers/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.reciveUserEmail, required this.reciveUseruid});

  final String reciveUserEmail;
  final String reciveUseruid;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timestamp? _lastMessageTimestamp;

  void sendMessge() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.reciveUseruid, _messageController.text);
      _messageController.clear();
    }
  }

  void showTimeonChat(String time) {
    setState(() {
      time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciveUserEmail),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _buildMessgeList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessgeList() {
    return StreamBuilder(
      stream:
          _chatService.getMessage(widget.reciveUseruid, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // box of show message in chat view
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var aliment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.bottomLeft;

    Timestamp timestamp =
        data['timeStemp']; // Assuming your timestamp field is named 'timestamp'
    DateTime dateTime =
        timestamp.toDate(); // Convert Firestore Timestamp to DateTime

    bool showTime = false;
    if (_lastMessageTimestamp == null ||
        dateTime.difference(_lastMessageTimestamp!.toDate()).inMinutes >= 15) {
      showTime = true;
      _lastMessageTimestamp = timestamp;
    }

    return Container(
      alignment: aliment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (showTime)
              Center(
                child: Text(
                  DateFormat('MMM dd, yyyy - HH:mm').format(dateTime),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            Text(data['senderEmail']),
            SizedBox(
              height: 10,
            ),
            ChatBouble(message: data['message'])
          ],
        ),
      ),
    );
  }

  // bos of input message
  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Enter message",
                ),
                controller: _messageController,
              ),
            ),
            IconButton(
              onPressed: sendMessge,
              icon: Icon(Icons.arrow_upward_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
