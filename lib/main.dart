import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Screens/Addproduck.dart';
import 'package:shopping/Screens/categoryproduct.dart';
import 'package:shopping/Screens/details.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/Screens/singup.dart';
import 'package:shopping/Screens/updatepage.dart';
import 'package:shopping/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    routes: {
      UpdatePage.id: (context) => UpdatePage(),
      Homepage.id: (context) => Homepage(),
      LoginPage.id: (context) => LoginPage(),
      Details.id: (context) => Details(),
      SignUpPage.id: (context) => SignUpPage(),
      Addproduck.id: (context) => Addproduck(),
      CategoryProduct.id: (context) => CategoryProduct(),
    },
    initialRoute: Homepage.id,
    // Ensure Homepage.id is defined in Homepage class
  ));
}
