import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockerFilterDialog extends StatefulWidget {
  const LockerFilterDialog({super.key});

  @override
  State<LockerFilterDialog> createState() => _LockerFilterDialogState();
}

class _LockerFilterDialogState extends State<LockerFilterDialog> {
  String? selectedYear;
  String? selectedSemester;
  int? selectedBuilding;

  final academicYears = ["2023-2024", "2024-2025", "2025-2026", "2026-2027"];
  final semesters = ["1st", "2nd"];
  // Fetch buildings from API
  final buildings = {1: "IC Building"};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Available Lockers",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Palette.darkShadePrimary,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Academic Year
            DropdownButtonFormField<String>(
              initialValue: selectedYear,
              decoration: const InputDecoration(labelText: "Academic Year"),
              items: academicYears
                  .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                  .toList(),
              onChanged: (val) => setState(() => selectedYear = val),
            ),

            const SizedBox(height: 12),

            /// Semester
            DropdownButtonFormField<String>(
              initialValue: selectedSemester,
              decoration: const InputDecoration(labelText: "Semester"),
              items: semesters
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => selectedSemester = val),
            ),

            const SizedBox(height: 12),

            /// Building (Optional)
            DropdownButtonFormField<int>(
              initialValue: selectedBuilding,
              decoration: const InputDecoration(
                labelText: "Building (Optional)",
              ),
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text("All Buildings"),
                ),
                ...buildings.entries.map(
                  (b) => DropdownMenuItem(value: b.key, child: Text(b.value)),
                ),
              ],
              onChanged: (val) => setState(() => selectedBuilding = val),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            context.read<LockerCubit>().resetAndLoad();
            Navigator.pop(context);
          },
          child: const Text("Reset"),
        ),

        ElevatedButton(
          onPressed: () {
            if (selectedYear == null || selectedSemester == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Select year & semester")),
              );
              return;
            }

            context.read<LockerCubit>().loadAvailableLockers(
              academicYear: selectedYear!,
              building: selectedBuilding,
              semester: selectedSemester!,
            );

            Navigator.pop(context);
          },
          child: const Text("Apply"),
        ),
      ],
    );
  }
}
