import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class ReportHeader extends StatelessWidget {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Report an Issue",
          style: TextStyle(
            color: Palette.darkShadePrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        /// Description
        Text(
          "If you are experiencing a problem with your subscribed locker, "
          "please provide clear and accurate details below.",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
