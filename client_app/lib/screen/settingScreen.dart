import 'package:flutter/material.dart';

class SettingScreenApp extends StatefulWidget {
  const SettingScreenApp({super.key});

  @override
  State<SettingScreenApp> createState() => _SettingScreenAppState();
}

class _SettingScreenAppState extends State<SettingScreenApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {  },
            icon: Icon(Icons.dehaze), 
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width *0.2,
              backgroundColor: Colors.white70
            ),
            Center(
              child: Column(children: [
                Text("Name"),
                Text("company")
              ]),
            )
          ],
        ),
      ),
    );
  }
}