import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_button.dart';
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
      Image.asset(
        "assets/img/background_classroom.jfif",
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
            BlocBuilder<LockerCubit, LockerState>(
              builder: (context, state) {
                final lockers = state.lockers;
                final Map<int, BuildingEntity> uniqueBuildings = {};

                for (var locker in lockers) {
                  final BuildingEntity building = locker.building;
                  uniqueBuildings[building.id] = building;
                }

                final buildingsList = uniqueBuildings.values.toList();

                return CustomDropdown<BuildingEntity>(
                  hintText: 'Buildings',
                  items: buildingsList,
                  initialItem: selectedBuilding,
                  onChanged: (value) {
                    setState(() {
                      selectedBuilding = value;
                    });
                  },
                );
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
          child: const Text("Reset Filter"),
        ),

        BrowseButton(
          onSubmitButton: () {
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

            Navigator.pop(context, {
              "academic_year": selectedYear,
              "building": selectedBuilding?.id,
              "semester": selectedSemester,
              // Additional Field for more clarity
              "building_name": selectedBuilding?.name,
            });
          },
          stateOnSubmit: Text("Apply"),
        ),
      ],
    );
  }
}
