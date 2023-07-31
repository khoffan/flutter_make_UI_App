


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import '../UI/dropdown.dart';
import '../providers/auth_user.dart';

import 'loadingScreen.dart';


class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int? _count;
  bool isDefaultColor = true; // Track the current state
  Color? containerColor = Colors.transparent;
  Color? containerTextColor = const Color.fromARGB(0, 0, 0, 0);

  bool isDefaultColor1 = true; // Track the current state
  Color? containerColor1 = Colors.transparent;
  Color? containerTextColor1 = const Color.fromARGB(0, 0, 0, 0);
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services Page'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _count = 0;
                    isDefaultColor =
                        !isDefaultColor; // Toggle the current state
                    containerColor = isDefaultColor
                        ? Colors.transparent
                        : Color.fromARGB(255, 108, 239, 60);
                    containerTextColor =
                        isDefaultColor ? Colors.transparent : Colors.white;

                    print(_count);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(30),
                    color:
                        containerColor, // Use the containerColor variable here
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ผู้รับฝาก",
                        style: TextStyle(
                            fontSize: 15,
                            color: containerTextColor = Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.motorcycle,
                            size: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _count = 1;
                    isDefaultColor1 =
                        !isDefaultColor1; // Toggle the current state
                    containerColor1 = isDefaultColor1
                        ? Colors.transparent
                        : Color.fromARGB(255, 108, 239, 60);
                    containerTextColor1 =
                        isDefaultColor1 ? Colors.transparent : Colors.white;
                    print(_count);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(30),
                    color:
                        containerColor1, // Use the containerColor variable here
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ผู้ฝาก",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.local_grocery_store,
                            size: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "please selext location for services",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    DropdoenWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_count == 0 && uid != '') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LoadingScreen(uid: uid ),
                        ),
                      );
                      AuthUsers().updateStatus(false,uid);
                    } else if(_count == 1 && uid != '') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LoadingScreen(uid: uid ),
                        ),
                      );
                      AuthUsers().updateStatus(true,uid);
                    }
                  },
                  child: Text("Matching"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
