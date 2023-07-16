import 'package:flutter/material.dart';

import '../UI/btnavigate.dart';
import '../UI/btnavigater_responder.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BottomNavigationBarAppRequester()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ผู้รับฝาก",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BottomNavigationBarAppResponder()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ผู้ฝาก",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.local_grocery_store,
                            size: 20, color: Colors.blue),
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
}
