import 'package:flutter/material.dart';

class SubscriptionTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final String label;
  final String? Function(String?)? validator;
  final bool hideText;
  final bool readOnly;

  const SubscriptionTextField({
    super.key,
    required this.fieldController,
    required this.label,
    this.validator,
    this.hideText = false,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: hideText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: validator,
    );
  }
}
