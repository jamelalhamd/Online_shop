import 'package:flutter/material.dart';

class ReusableTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Icon? preIcon;
  final Icon? sufeIcon;
  final ValueChanged<String>? onChanged;

  const ReusableTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text, // Default value
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.preIcon,
    this.sufeIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),

      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: widget.sufeIcon,
        prefixIcon: widget.preIcon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 20,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      validator: widget.validator, // Pass as reference
    );
  }
}
