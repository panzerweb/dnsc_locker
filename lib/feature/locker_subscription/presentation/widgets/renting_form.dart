import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/sub_details_tile.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/subscription_button.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_toastify/my_toastify.dart';

class RentingForm extends StatefulWidget {
  final LockerEntity locker;
  final Map<String, dynamic> filters;
  const RentingForm({super.key, required this.locker, required this.filters});

  @override
  State<RentingForm> createState() => _RentingFormState();
}

class _RentingFormState extends State<RentingForm> {
  final _formKey = GlobalKey<FormState>();
  String academicYear = '';
  String semesterValue = '';
  final bool _isSubmitting = false;

  @override
  void initState() {
    academicYear = widget.filters['academic_year'];
    semesterValue = widget.filters['semester'];

    super.initState();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "locker": widget.locker.id, // important for API
      "acedemic_year": academicYear,
      "semester": semesterValue,
    };

    print("POST Payload → $payload");

    // 👉 Call Bloc / API here
    // context.read<RentCubit>().rentLocker(payload);

    Toastify.show(
      context,
      message: 'Request submitted successfully. Please wait for approval.',
      type: ToastType.success,
      position: ToastPosition.bottom,
      style: ToastStyle.banner,
      leading: const Icon(Icons.check_circle, color: Colors.white),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubDetailsTile(
              leading: Icon(Icons.dns),
              title: 'Locker No.',
              subtitle: widget.locker.lockerNumber,
            ),
            SubDetailsTile(
              leading: Icon(Icons.apartment),
              title: 'Location',
              subtitle:
                  "${widget.locker.building.name} - Floor ${widget.locker.floor}",
            ),
            SubDetailsTile(
              leading: Icon(Icons.info),
              title: 'Condition',
              subtitle: widget.locker.isActive == true
                  ? 'Available'
                  : 'Unavailable',
            ),

            const SizedBox(height: 16),

            Center(
              child: Column(
                children: [
                  Text(
                    "Review your details below",
                    style: TextStyle(
                      color: Palette.darkShadePrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Your personal details are already included once you submit a request",
                    style: TextStyle(color: Palette.darkShadeSecondary),
                  ),
                  Divider(color: Palette.darkShadeSecondary, thickness: 2),

                  const SizedBox(height: 8),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(
                          color: Palette.accentColor,
                        );
                      }

                      if (state is AuthenticatedUserLoaded) {
                        final UserEntity user = state.user;
                        // Handling of user details
                        final String? firstName = user.student?.firstName;
                        final String? lastName = user.student?.lastName;
                        final String? suffixName = user.student?.suffix;
                        final String? studentId =
                            user.student?.studentId ?? 'Not Set';
                        final String? studentProgram =
                            user.student?.programName;
                        final String? studentYear = user.student?.studentLevel
                            .toString();
                        final String? studentSet = user.student?.studentSet;

                        final studentNameParts =
                            [firstName, lastName, suffixName]
                                .where(
                                  (name) =>
                                      name != null && name.trim().isNotEmpty,
                                )
                                .toList();
                        final studentDetailPart =
                            [studentProgram, studentYear, studentSet].where(
                              (detail) =>
                                  detail != null && detail.trim().isNotEmpty,
                            );

                        final fullName = studentNameParts.isEmpty
                            ? "Not Set"
                            : studentNameParts.join(" ");

                        final studentProgramYearLevel =
                            studentDetailPart.isEmpty
                            ? "Not Set"
                            : studentDetailPart.join(" ");

                        // User Interface
                        return Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(8, 0, 8, 0),
                          child: Column(
                            spacing: 4,
                            children: [
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  "Full Name",
                                  style: TextStyle(
                                    color: Palette.darkShadePrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  fullName,
                                  style: TextStyle(
                                    color: Palette.darkShadeSecondary,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.card_membership),
                                title: Text(
                                  "Student ID",
                                  style: TextStyle(
                                    color: Palette.darkShadePrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "$studentId",
                                  style: TextStyle(
                                    color: Palette.darkShadeSecondary,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.school_sharp),
                                title: Text(
                                  "Program/Year/Set",
                                  style: TextStyle(
                                    color: Palette.darkShadePrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  studentProgramYearLevel,
                                  style: TextStyle(
                                    color: Palette.darkShadeSecondary,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.calendar_month),
                                title: Text(
                                  "Academic Year",
                                  style: TextStyle(
                                    color: Palette.darkShadePrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  academicYear,
                                  style: TextStyle(
                                    color: Palette.darkShadeSecondary,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.timelapse_sharp),
                                title: Text(
                                  "Semester",
                                  style: TextStyle(
                                    color: Palette.darkShadePrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  semesterValue,
                                  style: TextStyle(
                                    color: Palette.darkShadeSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),

                  Divider(color: Palette.darkShadeSecondary, thickness: 2),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Submit Button
            SubscriptionButton(
              onSubmitButton: _isSubmitting ? null : _submit,
              stateOnSubmit: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Confirm Renting"),
            ),
          ],
        ),
      ),
    );
  }
}
/*

  The code below is still not yet necessary so I deprecated it.
  However, if this will be necessary in the future, then implement
  the textfield

*/
// DropdownButtonFormField<String>(
//   initialValue: _semester ?? '1st',
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//     ),
//     floatingLabelBehavior: FloatingLabelBehavior.never,
//   ),
//   items: semesters
//       .map((s) => DropdownMenuItem(value: s, child: Text(s)))
//       .toList(),
//   onChanged: (value) => setState(() => _semester = value),
//   validator: (value) => value == null ? "Select semester" : null,
// ),

// Center(
//   child: Column(
//     children: [
//       Text(
//         "Duration details",
//         style: TextStyle(
//           color: Palette.darkShadePrimary,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),

//       Text(
//         "Filtered values from earlier are now prefilled in the fields.",
//         style: TextStyle(color: Palette.darkShadeSecondary),
//       ),

//       Divider(color: Palette.darkShadeSecondary, thickness: 2),

//       /// Academic Year
//       Text(
//         "Academic Year",
//         style: TextStyle(
//           color: Palette.accentColor,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.start,
//       ),

//       const SizedBox(height: 8),

//       SubscriptionTextField(
//         fieldController: _academicYearController,
//         label: 'Academic Year',
//         readOnly: true,
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return "Enter academic year";
//           }

//           // Match YYYY-YYYY
//           final regex = RegExp(r'^\d{4}-\d{4}$');
//           if (!regex.hasMatch(value)) {
//             return "Format must be YYYY-YYYY";
//           }

//           final parts = value.split("-");
//           final startYear = int.tryParse(parts[0]);
//           final endYear = int.tryParse(parts[1]);

//           if (startYear == null || endYear == null) {
//             return "Invalid year format";
//           }

//           if (endYear != startYear + 1) {
//             return "Academic year must be consecutive (e.g. 2025-2026)";
//           }

//           return null;
//         },
//       ),

//       const SizedBox(height: 16),

//       Text(
//         "Semester",
//         style: TextStyle(
//           color: Palette.accentColor,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.start,
//       ),

//       const SizedBox(height: 8),

//       /// Semester Dropdown
//       SubscriptionTextField(
//         fieldController: _semesterController,
//         label: "Semester",
//         readOnly: true,
//       ),
//     ],
//   ),
// ),
