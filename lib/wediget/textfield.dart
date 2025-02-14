import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final Icon? preIcon;
  final Icon? suffIcon;
  final ValueChanged<String>? onChanged;

  const ReusableTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text, // Default value
    required this.hintText,
    this.obscureText = false,
    this.preIcon,
    this.suffIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffIcon,
        prefixIcon: preIcon,
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
