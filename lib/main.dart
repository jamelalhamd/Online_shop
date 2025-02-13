import 'package:flutter/material.dart';
import 'package:shopping/Screens/details.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/Screens/singup.dart';
import 'package:shopping/Screens/updatepage.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    routes: {
      UpdatePage.id: (context) => UpdatePage(),
      Homepage.id: (context) => Homepage(),
      LoginPage.id: (context) => LoginPage(),
      Details.id: (context) => Details(),
      SignUpPage.id: (context) => SignUpPage(),
    },
    initialRoute: LoginPage.id,
    // Ensure Homepage.id is defined in Homepage class
  ));
}
