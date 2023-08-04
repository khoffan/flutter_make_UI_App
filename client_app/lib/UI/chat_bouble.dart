import 'package:flutter/material.dart';

class ChatBouble extends StatelessWidget {

  const ChatBouble({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        message, style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}