import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/payment_transactions/presentation/widgets/transaction_details_tile.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'Transactions'),
      /*
        Adapt infinite scrolling here for list of transactions
        A dynamic data shall be displayed here
      */
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return TransactionDetailsTile(
              leading: Icon(Icons.payment_rounded),
              title: 'Locker Payment',
              subtitle:
                  'You have paid Php 50.00, your balance is now Php 100.00',
              trailing: Text("Feb 15, 2026"),
            );
          },
        ),
      ),
    );
  }
}
