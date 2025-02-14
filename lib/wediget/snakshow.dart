import 'package:flutter/material.dart';

// Reusable method to show SnackBar
void ReusableSnackBar(BuildContext context,
    {required String message,
    Duration duration = const Duration(seconds: 3),
    IconData icon = Icons.check_circle,
    Color backgroundColor = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, // Custom icon passed as parameter
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              message, // Custom message passed as parameter
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor, // Custom background color
      behavior: SnackBarBehavior.floating, // Floating behavior
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
      ),
      margin: EdgeInsets.all(20), // Margin around SnackBar
      duration: duration, // Custom duration
    ),
  );
}
