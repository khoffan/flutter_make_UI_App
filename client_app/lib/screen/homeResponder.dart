import 'package:flutter/material.dart';

class HomeResponder extends StatelessWidget {
  const HomeResponder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeResponder'),
      ),
      body: Center(
        child: Text("Responder page"),
      ),
    );
  }
}