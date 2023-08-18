import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double moneyCount = 500.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hello, Wallet App",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "จำนวนเงิน",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${moneyCount.toString()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.attach_money)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildComponent('โอนเงิน'),
                          _buildComponent('เติมเงิน'),
                          _buildComponent('บัญชี'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildComponent('รายการ'),
                          _buildComponent('ถอนเงิน'),
                          _buildComponent('ตั่งค่า'),
                        ],
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

Widget _buildComponent(String title) {
  if (title == "โอนเงิน") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: ClipOval(
            child: Image.asset(
              'assets/transfer.png',
              width: 40, // Customize the width of the image
              height: 40, // Customize the height of the image
              fit: BoxFit.cover,
              color: Colors.blue,
 // Adjust how the image fills the ClipOval
            ),
          ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  }
  if (title == "เติมเงิน") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: ClipOval(
            child: Image.asset(
              'assets/dollar.png',
              width: 40, // Customize the width of the image
              height: 40, // Customize the height of the image
              fit: BoxFit.cover,
// Adjust how the image fills the ClipOval
            ),
          ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  }
  if (title == "บัญชี") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: ClipOval(
            child: Image.asset(
              'assets/folder.png',
              width: 40, // Customize the width of the image
              height: 40, // Customize the height of the image
              fit: BoxFit.cover, // Adjust how the image fills the ClipOval
            ),
          ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  }
  if (title == "รายการ") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: ClipOval(
            child: Image.asset(
              'assets/check-list.png',
              width: 40, // Customize the width of the image
              height: 40, // Customize the height of the image
              // fit: BoxFit.cover,
// Adjust how the image fills the ClipOval
            ),
          ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  }
  if (title == "ถอนเงิน") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      Container(
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: Image.asset(
              'assets/withdrawal.png',
              width: 40, // Customize the width of the image
              height: 40, // Customize the height of the image
              fit: BoxFit.cover,
              color: Colors.green, // Adjust how the image fills the ClipOval
            ),
          ),
          // child: Icon(Icons.add),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  }
  if (title == "ตั่งค่า") {
    return Column(children: [
      Padding(padding: EdgeInsetsDirectional.only()),
      // Monday
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.settings,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(title)
    ]);
  } else {
    return Container();
  }
}
