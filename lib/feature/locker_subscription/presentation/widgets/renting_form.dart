import 'package:flutter/material.dart';

class RentingForm extends StatefulWidget {
  const RentingForm({super.key});

  @override
  State<RentingForm> createState() => _RentingFormState();
}

class _RentingFormState extends State<RentingForm> {
  late final TextEditingController _lockerController;

  @override
  void initState() {
    // Replace text arguments of TextEditingController with
    // widget.entity.entityProperties
    // Example: widget.locker.lockerNo

    _lockerController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [TextField(controller: _lockerController)]);
  }
}
