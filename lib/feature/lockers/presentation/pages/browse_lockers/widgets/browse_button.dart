import 'package:flutter/material.dart';

class BrowseButton extends StatelessWidget {
  final void Function()? onSubmitButton;
  final Widget stateOnSubmit;

  const BrowseButton({
    super.key,
    required this.onSubmitButton,
    required this.stateOnSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onSubmitButton,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[900],
          foregroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
        child: stateOnSubmit,
      ),
    );
  }
}
