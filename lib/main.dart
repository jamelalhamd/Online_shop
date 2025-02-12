import 'package:flutter/material.dart';
import 'package:shopping/Screens/details.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/Screens/updatepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    routes: {
      Updatepage.id: (context) => Updatepage(),
      Homepage.id: (context) => Homepage(),
      Login.id: (context) => Login(),
      Details.id: (context) => Details(),
    },
    initialRoute: Homepage.id,
    // Ensure Homepage.id is defined in Homepage class
  ));
}
