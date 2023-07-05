import 'package:client_app/providers/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/btnavigate.dart';
void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return InfoProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavigationBarExampleApp()
      ),
    );
  }
}

