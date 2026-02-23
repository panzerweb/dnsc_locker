import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/renting_form.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentingScreenPage extends StatelessWidget {
  final String lockerId;
  final Map<String, dynamic> filters;

  const RentingScreenPage({
    super.key,
    required this.lockerId,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Rent Locker'),

      /*
        Use a blocbuilder in the future with the locker entity
        and iterate through the list of lockers until matched
        with the lockerId.

        RentingForm() must accept a LockerEntity parameter
      */
      body: BlocBuilder<LockerCubit, LockerState>(
        builder: (context, state) {
          for (var locker in state.lockers) {
            if (locker.id == int.tryParse(lockerId)) {
              return RentingForm(locker: locker, filters: filters);
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
