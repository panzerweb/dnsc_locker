import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/payment_transactions/presentation/widgets/transaction_details_tile.dart';
import 'package:dnsc_locker/feature/payment_transactions/presentation/widgets/transaction_page_header_section.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String amountPaid = "50";
    final String currentBalance = "100";

    return Scaffold(
      appBar: MainAppbar(title: 'Transactions'),
      /*
        Adapt infinite scrolling here for list of transactions
        A dynamic data shall be displayed here
      */
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionPageHeaderSection(),
            const SizedBox(height: 16),

            /*
              Latest transaction view
            */
            Text(
              "Latest Transaction",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Palette.darkShadeSecondary,
              ),
            ),
            const SizedBox(height: 12),

            TransactionDetailsTile(
              leading: const Icon(Icons.payment_rounded),
              title: 'Locker Payment',
              amountPaid: amountPaid,
              currentBalance: currentBalance,
              trailing: const Text("Feb 15, 2026"),
            ),
            const SizedBox(height: 12),

            /*
              Previous transactions view
            */
            Text(
              "Previous Transactions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Palette.darkShadeSecondary,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TransactionDetailsTile(
                    leading: const Icon(Icons.payment_rounded),
                    title: 'Locker Payment',
                    amountPaid: amountPaid,
                    currentBalance: currentBalance,
                    trailing: const Text("Feb 15, 2026"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
