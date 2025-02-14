import 'package:flutter/material.dart';

class ReusableTextFormFielPassword extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  const ReusableTextFormFielPassword({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.onChanged,
    required this.isPassword,
  }) : super(key: key);

  @override
  _ReusableTextFormFielPasswordState createState() =>
      _ReusableTextFormFielPasswordState();
}

class _ReusableTextFormFielPasswordState
    extends State<ReusableTextFormFielPassword> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 18, color: Colors.blue),
      controller: widget.controller,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : TextInputType.text,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? isObscured : false,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.labelText} cannot be empty';
        }
        if (widget.isPassword && value.length < 6) {
          return "Password must be at least 6 characters long";
        }
        return null;
      },
    );
  }
}
