import 'package:flutter/material.dart';

import '../UI/btnavigate.dart';
import '../UI/btnavigater_responder.dart';
import '../UI/dropdown.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int? count;
  bool isDefaultColor = true; // Track the current state
  Color? containerColor = Colors.transparent;
  Color? containerTextColor = const Color.fromARGB(0, 0, 0, 0);

  bool isDefaultColor1 = true; // Track the current state
  Color? containerColor1 = Colors.transparent;
  Color? containerTextColor1 = const Color.fromARGB(0, 0, 0, 0);
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
                    count = 0;
                    isDefaultColor =
                        !isDefaultColor; // Toggle the current state
                    containerColor =
                        isDefaultColor ? Colors.transparent : const Color.fromARGB(255, 214, 214, 214);
                    containerTextColor =  isDefaultColor ? Colors.transparent : Colors.white;
                    
                    print(count);
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
                        style: TextStyle(fontSize: 15, color: containerTextColor = Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.motorcycle,
                            size: 20, color: Colors.blue),
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
                    count = 1;
                    isDefaultColor1 =
                        !isDefaultColor1; // Toggle the current state
                    containerColor1 =
                        isDefaultColor1 ? Colors.transparent : const Color.fromARGB(255, 214, 214, 214);
                    containerTextColor1 = isDefaultColor1 ? Colors.transparent : Colors.white;
                    print(count);
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
                        style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 57, 245)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.local_grocery_store,
                            size: 20, color: Colors.blueAccent),
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
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    DropdoenWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
