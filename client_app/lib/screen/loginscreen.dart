// import 'dart:convert';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/login.dart';
// import 'package:http/http.dart' as http;
import '../UI/btnavigate.dart';
// import '../providers/user_provider.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Future log_in() async {
  //   String url = 'http://172.22.118.252/api_flutter/login.php';
  //   final res = await http.post(Uri.parse(url), body: {
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //   });
  //   var data = json.decode(res.body);
  //   print(data);
  //   if(data == 'error'){
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => LoginScreen(),
  //       ),
  //     );
  //   }
  //   else {
  //     await Users.setLogin(true);
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => BottomNavigationBarExampleApp(),
  //       ),
  //     );
  //   }
  // }

//   Widget buildEmail() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Email',
//             style: TextStyle(fontSize: 18, color: Colors.black)),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 const BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: Offset(0, 2),
//                 )
//               ]),
//           height: 60,
//           child: TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.black,
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 12),
//               prefixIcon: Icon(
//                 Icons.mail,
//               ),
//               hintText: "Email",
//               hintStyle: TextStyle(color: Colors.black26),
//             ),
//             controller: emailController,
//             validator: (val){
//               if(val == null || val.isEmpty){
//                 return "Please enter your username or emmail";
//               }
//               return null;
//             },
//           ),
//         )
//       ],
//     ),
//   );
// }

//   Widget buildPassword() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Password',
//               style: TextStyle(fontSize: 18, color: Colors.black)),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   const BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 2),
//                   )
//                 ]),
//             height: 60,
//             child: TextFormField(
//               obscureText: true,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.only(top: 12),
//                 prefixIcon: Icon(
//                   Icons.lock,
//                 ),
//                 hintText: "Password",
//                 hintStyle: TextStyle(color: Colors.black26),
//               ),
//               controller: passwordController,
//               validator: (val) {
//                 if(val == null || val.isEmpty){
//                   return "Please enter your password";
//                 }
//                 return null;
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

  // Widget buildLoginbtn(context) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
  //     width: double.infinity,
  //     child: TextButton(
  //       onPressed: () {
  //         bool p = _fromKey.currentState?.validate() ?? false;

  //         if(p){
  //           log_in();
  //         }
  //       },
  //       style: TextButton.styleFrom(
  //         backgroundColor: Colors.blue,
  //       ),
  //       child: Text(
  //         "Login",
  //         style: TextStyle(color: Colors.black, fontSize: 20),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildSignupbtn(context) {

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Login login = Login(email: '', password: '');

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                          //make felid input text
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.black,
                            hintText: "Email",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          onSaved: (val) => login.email = val.toString(),
                          controller: emailController,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter your Email';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.all(15),
                          fillColor: Colors.black,
                          hintText: "Password",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        onSaved: (val) {
                          login.password = val.toString();
                        },
                        controller: passwordController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarExampleApp()));
                              }
                            },
                            child: Text("Login"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("if you don't have account? "),
                  TextButton(
                    child: Text(
                      "sign-up",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: AnnotatedRegion<SystemUiOverlayStyle>(
    //     value: SystemUiOverlayStyle.light,
    //     child: Form(
    //       key: _fromKey,
    //       child: GestureDetector(
    //         child: Stack(
    //           children: <Widget>[
    //             Container(
    //               height: double.infinity,
    //               width: double.infinity,
    //               decoration: const BoxDecoration(),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   const Text(
    //                     'Login',
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 40,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 40,
    //                   ),
    //                   buildEmail(),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   buildPassword(),
    //                   SizedBox(
    //                     height: 40,
    //                   ),
    //                   // buildLoginbtn(context),
    //                   Container(
    //                     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
    //                     width: double.infinity,
    //                     child: TextButton(
    //                       onPressed: () {
    //                         if (_fromKey.currentState?.validate() ?? false) {
    //                           log_in();
    //                           // Navigator.of(context).pop();
    //                         }
    //                       },
    //                       style: TextButton.styleFrom(
    //                         backgroundColor: Colors.blue,
    //                       ),
    //                       child: Text(
    //                         "Login",
    //                         style: TextStyle(color: Colors.black, fontSize: 20),
    //                       ),
    //                     ),
    //                   ),
    //                   buildSignupbtn(context),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
