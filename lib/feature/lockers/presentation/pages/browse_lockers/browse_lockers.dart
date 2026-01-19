import 'package:flutter/material.dart';

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Browse Lockers Page"));
  }
}
