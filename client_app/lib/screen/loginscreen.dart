import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../UI/btnavigate.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Widget buildEmail() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email',
            style: TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12),
              prefixIcon: Icon(
                Icons.mail,
              ),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.black26),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildPassword() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password',
            style: TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12),
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.black26),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildLoginbtn(context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
    width: double.infinity,
    child: TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavigationBarExampleApp(),
        ));
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    ),
  );
}

Widget buildSignupbtn(context) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          ));
        },
        child: Text(
          "sign up",
          style: TextStyle(color: Colors.red),
        ),
      ));
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    buildEmail(),
                    SizedBox(
                      height: 20,
                    ),
                    buildPassword(),
                    SizedBox(
                      height: 40,
                    ),
                    buildLoginbtn(context),
                    buildSignupbtn(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
