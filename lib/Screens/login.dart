import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = 'login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
      ),
    );
  }
}
