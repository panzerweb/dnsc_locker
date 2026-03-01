import 'package:flutter/material.dart';

class UniversalTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final String label;
  final String? Function(String?)? validator;
  final bool hideText;
  final bool readOnly;

  /// Textarea options
  final bool expanding;
  final int? maxLines;
  final int? minLines;

  const UniversalTextField({
    super.key,
    required this.fieldController,
    required this.label,
    this.validator,
    this.hideText = false,
    this.readOnly = false,
    this.expanding = false,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: hideText,
      readOnly: readOnly,
      validator: validator,

      /// Important textarea logic
      expands: expanding,
      maxLines: expanding ? null : maxLines,
      minLines: expanding ? null : minLines,

      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        alignLabelWithHint: true, // fixes label position for textarea
      ),
    );
  }
}
