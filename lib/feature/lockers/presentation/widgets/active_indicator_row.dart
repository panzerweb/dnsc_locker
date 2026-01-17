import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class ActiveIndicatorRow extends StatelessWidget {
  const ActiveIndicatorRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        Icon(Icons.circle, color: Colors.green),
        Text(
          "Active Locker",
          style: TextStyle(
            color: Palette.darkShadePrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
