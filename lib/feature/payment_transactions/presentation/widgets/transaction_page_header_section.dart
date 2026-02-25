import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class TransactionPageHeaderSection extends StatelessWidget {
  final String? instituteDetailName;
  const TransactionPageHeaderSection({super.key, this.instituteDetailName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Palette.darkShadePrimary,
          ),
        ),
        Text(
          instituteDetailName ?? '',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Palette.darkShadeSecondary,
          ),
        ),
      ],
    );
  }
}
