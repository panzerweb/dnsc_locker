import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final String label;
  final String? Function(String?)? validator;
  final bool hideText;

  const AuthTextField({
    super.key,
    required this.fieldController,
    required this.label,
    this.validator,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: validator,
    );
  }
}
