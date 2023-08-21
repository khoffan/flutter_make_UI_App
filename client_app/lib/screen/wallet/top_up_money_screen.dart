import 'package:flutter/material.dart';

class TopupMoneyScreen extends StatefulWidget {
  const TopupMoneyScreen({super.key});

  @override
  State<TopupMoneyScreen> createState() => _TopupMoneyScreenState();
}

class _TopupMoneyScreenState extends State<TopupMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Text('Topup'),
      ),
    );
  }
}