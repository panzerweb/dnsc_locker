import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/renting_form.dart';
import 'package:flutter/material.dart';

class RentingScreenPage extends StatelessWidget {
  final String lockerId;
  const RentingScreenPage({super.key, required this.lockerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Rent this locker'),

      /*
        Use a blocbuilder in the future with the locker entity
        and iterate through the list of lockers until matched
        with the lockerId.

        RentingForm() must accept a LockerEntity parameter
      */
      body: RentingForm(),
    );
  }
}
