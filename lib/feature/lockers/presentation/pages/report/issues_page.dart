import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:flutter/material.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Issues'),
      body: Center(
        child: Text(
          "This page will view all issues submitted by the user",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
