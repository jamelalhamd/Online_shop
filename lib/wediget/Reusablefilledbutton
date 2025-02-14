import 'package:flutter/material.dart';

class ReusableFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String buttonText;

  const ReusableFilledButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              buttonText,
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
}
