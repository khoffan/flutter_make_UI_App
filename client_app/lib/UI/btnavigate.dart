import 'package:client_app/screen/home/homeResponder.dart';
import 'package:client_app/screen/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screen/home/home.dart';
import '../screen/qrcode/qrCodeScanner.dart';
import '../screen/service/serviceScreen.dart';
import '../screen/profile/profileScreen.dart';

/// Flutter code sample for [BottomNavigationBar].
class BottomNavigationBarAppRequester extends StatelessWidget {
  const BottomNavigationBarAppRequester({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarScreen(),
    );
  }
}

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  PageController _pageController = PageController(initialPage: 0);

  static List<Widget> _widgetOptions = <Widget>[
    ContentPage(),
    WalletPage(),
    QrscannerScreen(),
    ProfileScreenApp(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _widgetOptions,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServiceScreen()),
            );
          },
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
                            FaIcon(FontAwesomeIcons.bank,
                                size: 20,
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
                            Icon(Icons.qr_code_scanner,
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
