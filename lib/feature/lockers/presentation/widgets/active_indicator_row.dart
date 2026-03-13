import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class ActiveIndicatorRow extends StatelessWidget {
  final String paymentStatus;
  final String status;

  const ActiveIndicatorRow({
    super.key,
    required this.paymentStatus,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final boolPaymentStatus = paymentStatus == 'unpaid' ? 'Unpaid' : 'Paid';
    final boolStatus = status == 'active' ? 'Active' : 'Inactive';

    return Row(
      spacing: 6,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle, color: Colors.green),
        Text(
          "$boolPaymentStatus & $boolStatus",
          style: TextStyle(
            color: Palette.lightShadeSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
