import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Requests'),
      body: Center(child: Text("Requests Page List")),
    );
  }
}
