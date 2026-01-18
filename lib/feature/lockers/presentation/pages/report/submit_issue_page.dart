import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:flutter/material.dart';

class SubmitIssuePage extends StatefulWidget {
  const SubmitIssuePage({super.key});

  @override
  State<SubmitIssuePage> createState() => _SubmitIssuePageState();
}

class _SubmitIssuePageState extends State<SubmitIssuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Submit an issue'),
      body: Center(
        child: Text(
          "A form for submitting an issue",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
