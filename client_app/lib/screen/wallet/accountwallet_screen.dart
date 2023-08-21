import 'package:flutter/material.dart';

class AcoountScreen extends StatefulWidget {
  const AcoountScreen({super.key});

  @override
  State<AcoountScreen> createState() => _AcoountScreenState();
}

class _AcoountScreenState extends State<AcoountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Text('Account'),),
    );
  }
}