import 'package:client_app/screen/chatpage.dart';
import 'package:client_app/screen/home.dart';
import 'package:flutter/material.dart';

import 'setting.dart';

/// Flutter code sample for [BottomNavigationBar].
class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    ChatPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    SettingUI()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        _onItemTapped(0);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home,
                                color: _selectedIndex == 0
                                    ? Colors.green
                                    : Colors.grey),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: _selectedIndex == 0
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        _onItemTapped(1);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat,
                                color: _selectedIndex == 1
                                    ? Colors.green
                                    : Colors.grey),
                            Text(
                              'chat',
                              style: TextStyle(
                                  color: _selectedIndex == 1
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                          ]),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        _onItemTapped(2);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school,
                                color: _selectedIndex == 2
                                    ? Colors.green
                                    : Colors.grey),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: _selectedIndex == 2
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        _onItemTapped(3);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.settings,
                                color: _selectedIndex == 3
                                    ? Colors.green
                                    : Colors.grey),
                            Text(
                              'chat',
                              style: TextStyle(
                                  color: _selectedIndex == 3
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
