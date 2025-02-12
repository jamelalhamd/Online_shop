import 'package:flutter/material.dart';
import 'package:shopping/Screens/details.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/Screens/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    routes: {
      Homepage.id: (context) => Homepage(),
      Login.id: (context) => Login(),
      Details.id: (context) => Details(),
    },
    initialRoute: Homepage.id,
    // Ensure Homepage.id is defined in Homepage class
  ));
}
