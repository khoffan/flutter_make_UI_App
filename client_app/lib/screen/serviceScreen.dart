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
  bool onClick = false;

  bool isDefaultColor1 = true; // Track the current state
  Color? containerColor = Colors.transparent;
  Color? containerTextColor = const Color.fromARGB(0, 0, 0, 0);

  bool isDefaultColor2 = true; // Track the current state
  Color? containerColor1 = Colors.transparent;
  Color? containerTextColor1 = const Color.fromARGB(0, 0, 0, 0);

  List<bool> buttonStates = [true, true, true];

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
              Expanded(
                flex: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    children: [
                      buildContainer("ผู้รับฝาก", Icons.motorcycle, 0),
                      SizedBox(height: 20),
                      buildContainer("ผู้ฝาก", Icons.local_grocery_store, 1),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 0,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ระยะเวลาการรับงาน',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          btnHourwork('1-3ชม', 0),
                          btnHourwork('4-6ชม', 1),
                          btnHourwork('6-8ชม', 2),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "please selext location for services",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
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
                              print(_count);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => LoadingScreen(uid: uid),
                                ),
                              );
                              AuthUsers().updateStatus(false, uid);
                            } else if (_count == 1 && uid != '') {
                              print(_count);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => LoadingScreen(uid: uid),
                                ),
                              );
                              AuthUsers().updateStatus(true, uid);
                            }
                          },
                          child: Text("Matching"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildContainer(String text, IconData iconData, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (count == 0) {
            isDefaultColor2 = true;
            isDefaultColor1 = !isDefaultColor1;
          } else if (count == 1) {
            isDefaultColor1 = true;
            isDefaultColor2 = !isDefaultColor2;
          }
          _count = count;
          print(isDefaultColor1);
          print(count);
          print(isDefaultColor2);
          print(count);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(30),
          color: count == 0
              ? (isDefaultColor1
                  ? Colors.transparent
                  : Color.fromARGB(255, 108, 239, 60))
              : (isDefaultColor2
                  ? Colors.transparent
                  : Color.fromARGB(255, 108, 239, 60)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(iconData, size: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector btnHourwork(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for(int i = 0; i < buttonStates.length; i++){
            if(i != index) {
              buttonStates[i] = true;
              onClick = buttonStates[i];
            }
          }
          buttonStates[index] = !buttonStates[index];
        });
        print(onClick);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
            // ignore: dead_code
            color: buttonStates[index] ? Colors.transparent : Colors.amber),
        child: Center(child: Text(title)),
      ),
    );
  }
}
