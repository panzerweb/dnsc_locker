import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class TransactionDetailsTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String amountPaid;
  final String currentBalance;
  final Widget? trailing;

  const TransactionDetailsTile({
    super.key,
    required this.leading,
    required this.title,
    required this.amountPaid,
    required this.currentBalance,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: IconTheme(
          data: IconThemeData(color: Palette.secondaryColor),
          child: leading,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Palette.darkShadePrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "You have paid the amount of $amountPaid, your balance is now $currentBalance",
          style: const TextStyle(
            color: Palette.darkShadeSecondary,
            fontSize: 14,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
