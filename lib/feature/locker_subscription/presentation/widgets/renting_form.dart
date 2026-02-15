import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/sub_details_tile.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/subscription_button.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/subscription_text_field.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentingForm extends StatefulWidget {
  final LockerEntity locker;
  const RentingForm({super.key, required this.locker});

  @override
  State<RentingForm> createState() => _RentingFormState();
}

class _RentingFormState extends State<RentingForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _academicYearController;

  String? _semester;
  final bool _isSubmitting = false;

  final semesters = ["1st", "2nd"];

  @override
  void initState() {
    _academicYearController = TextEditingController(
      text: _defaultAcademicYear(),
    );

    super.initState();
  }

  String _defaultAcademicYear() {
    final year = DateTime.now().year;
    return "$year-${year + 1}";
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "locker": widget.locker.id, // important for API
      "acedemic_year": _academicYearController.text,
      "semester": _semester,
    };

    print("POST Payload → $payload");

    // 👉 Call Bloc / API here
    // context.read<RentCubit>().rentLocker(payload);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Rent request submitted")));
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
                    "Fill the details below",
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
                        final user = state.user;

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
                                  "${user.student?.firstName} ${user.student?.lastName} ${user.student?.suffix}",
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
                                subtitle: Text("${user.student?.studentId}"),
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
                                  "${user.student?.programName} ${user.student?.studentLevel}${user.student?.studentSet}",
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

            const SizedBox(height: 16),

            /// Academic Year
            Text(
              "Academic Year",
              style: TextStyle(
                color: Palette.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            SubscriptionTextField(
              fieldController: _academicYearController,
              label: 'Academic Year',
              readOnly: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter academic year";
                }

                // Match YYYY-YYYY
                final regex = RegExp(r'^\d{4}-\d{4}$');
                if (!regex.hasMatch(value)) {
                  return "Format must be YYYY-YYYY";
                }

                final parts = value.split("-");
                final startYear = int.tryParse(parts[0]);
                final endYear = int.tryParse(parts[1]);

                if (startYear == null || endYear == null) {
                  return "Invalid year format";
                }

                if (endYear != startYear + 1) {
                  return "Academic year must be consecutive (e.g. 2025-2026)";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            Text(
              "Semester",
              style: TextStyle(
                color: Palette.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// Semester Dropdown
            DropdownButtonFormField<String>(
              initialValue: _semester ?? '1st',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              items: semesters
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) => setState(() => _semester = value),
              validator: (value) => value == null ? "Select semester" : null,
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
