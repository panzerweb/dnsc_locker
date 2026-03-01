import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:dnsc_locker/core/components/universal_form_button.dart';
import 'package:dnsc_locker/core/components/universal_text_field.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/reports/presentation/widgets/details_tile.dart';
import 'package:dnsc_locker/feature/reports/presentation/widgets/reminder_banner_card.dart';
import 'package:dnsc_locker/feature/reports/presentation/widgets/report_header.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SubmitIssuePage extends StatefulWidget {
  const SubmitIssuePage({super.key});

  @override
  State<SubmitIssuePage> createState() => _SubmitIssuePageState();
}

class _SubmitIssuePageState extends State<SubmitIssuePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _messageController = TextEditingController();

  // Temporary state, use State Management in the future
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: '');
    _messageController = TextEditingController(text: '');
  }

  // Submit the issue
  void _reportIssue() {
    print("Reported");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Submit an issue'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              ReportHeader(),

              const SizedBox(height: 24),

              /// Respect Reminder Card
              ReminderBannerCard(),

              const SizedBox(height: 20),

              /// Optional Divider Before Future Fields
              Divider(thickness: 1, color: Colors.grey.shade300),

              // Locker details
              DetailsTile(
                leading: Icon(Icons.dns),
                title: "Locker No.",
                // Inject real locker number
                subtitle: "01",
              ),

              const SizedBox(height: 8),

              // Form below with the actual fields
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: TextStyle(
                        color: Palette.darkShadePrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    UniversalTextField(
                      fieldController: _emailController,
                      label: 'Email Address',
                      readOnly: false,
                      validator: (value) {
                        final bool isValid = EmailValidator.validate(value!);
                        if (value.isEmpty) {
                          return "Email is required.";
                        }
                        if (!isValid) {
                          return "Invalid email address, fill it again properly.";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Message",
                      style: TextStyle(
                        color: Palette.darkShadePrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Flexible(
                      child: UniversalTextField(
                        fieldController: _messageController,
                        label: 'Please fill your concerns here...',
                        readOnly: false,
                        maxLines: 6,
                      ),
                    ),

                    const SizedBox(height: 16),

                    UniversalFormButton(
                      onSubmitButton: _isLoading ? null : _reportIssue,
                      stateOnSubmit: _isLoading
                          ? const CircularProgressIndicator(
                              color: Palette.accentColor,
                            )
                          : Text("Report an issue"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
