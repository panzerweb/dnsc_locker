import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class LockerFilterDialog extends StatefulWidget {
  const LockerFilterDialog({super.key});

  @override
  State<LockerFilterDialog> createState() => _LockerFilterDialogState();
}

class _LockerFilterDialogState extends State<LockerFilterDialog> {
  String? selectedYear;
  String? selectedSemester;
  BuildingEntity? selectedBuilding;

  final academicYears = ["2023-2024", "2024-2025", "2025-2026", "2026-2027"];
  final semesters = ["1st", "2nd"];
  // Fetch buildings from API
  final buildings = [
    BuildingEntity(
      id: 1,
      schoolName: "Davao del Norte State College",
      name: "IC Building",
      maxFloor: 2,
    ),
    BuildingEntity(
      id: 6,
      schoolName: "Davao del Norte State College",
      name: "ITED Building",
      maxFloor: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GiffyDialog.image(
      Image.network(
        "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
        height: 200,
        fit: BoxFit.cover,
      ),
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
            CustomDropdown<String>(
              hintText: 'Academic Year',
              items: academicYears,
              initialItem: selectedYear,
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
            ),
            const SizedBox(height: 12),

            /// Semester
            CustomDropdown<String>(
              hintText: 'Semester',
              items: semesters,
              initialItem: selectedSemester,
              onChanged: (value) {
                setState(() {
                  selectedSemester = value;
                });
              },
            ),

            const SizedBox(height: 12),

            /// Building (Optional)
            CustomDropdown<BuildingEntity>(
              hintText: 'Buildings',
              items: buildings,
              initialItem: selectedBuilding,
              onChanged: (value) {
                setState(() {
                  selectedBuilding = value;
                });
              },
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
            print("Academic Year: $selectedYear");
            print("Building: ${selectedBuilding?.id}");
            print("Semester: $selectedSemester");
            context.read<LockerCubit>().loadAvailableLockers(
              academicYear: selectedYear!,
              building: selectedBuilding?.id,
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
