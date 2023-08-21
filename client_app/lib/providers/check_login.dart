import 'package:client_app/providers/user_provider.dart';
import 'package:flutter/material.dart';

import '../UI/btnavigate.dart';
import '../screen/authentication/loginscreen.dart';


class checkLogin extends StatefulWidget {
  const checkLogin({super.key});

  @override
  State<checkLogin> createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {
  Future checklogin() async {
    bool? login = await Users.getLogin();
    if(login == false){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )
      );
    }
    else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BottomNavigationBarAppRequester(),
        )
      );
    }
  }

  void initState(){
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}