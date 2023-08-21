import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Page'),
      ),
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Text(
              'Swipe to go back',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
