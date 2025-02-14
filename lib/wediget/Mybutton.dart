import 'package:flutter/material.dart';

class RusableButtom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;

  // Constructor to take parameters for customization
  const RusableButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue, // Default background color
    this.textColor = Colors.white, // Default text color
    this.width = double.infinity, // Default width to fill available space
    this.height = 50.0, // Default height of the button
    this.fontSize = 16.0, // Default font size
    this.borderRadius = 8.0, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          // Background color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius), // Rounded corners
          ),
          textStyle: TextStyle(fontSize: fontSize),
        ),
        onPressed: onPressed, // Action when pressed
        child: Text(
          text, // Button text
          style: TextStyle(color: textColor), // Text color
        ),
      ),
    );
  }
}
