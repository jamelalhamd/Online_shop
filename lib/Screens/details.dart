import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});
  static const String id = 'details';
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('details'),
        centerTitle: true,
      ),
    );
  }
}
