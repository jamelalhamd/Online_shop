import 'package:flutter/material.dart';

class ReusableDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final String labelText;
  final Icon? prefixIcon;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const ReusableDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.labelText,
    this.prefixIcon, // Nullable prefixIcon
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon, // Will be null if not provided
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an option';
            }
            return null;
          },
    );
  }
}
