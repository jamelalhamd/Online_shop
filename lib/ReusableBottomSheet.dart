import 'package:flutter/material.dart';

class ReusableBottomSheet extends StatelessWidget {
  final List<Widget> children;

  const ReusableBottomSheet({
    Key? key,
    required this.children,
  }) : super(key: key);

  // Statische Methode zum Öffnen des Bottom Sheets
  static void show(BuildContext context, List<Widget> children) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReusableBottomSheet(children: children);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: double.infinity,
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
