import 'package:dnsc_locker/core/constant/institutes_enum.dart';
import 'package:dnsc_locker/core/helper/dnsc_email_validator.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/auth_button.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/auth_text_field.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/bottom_wave_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  InstitutesEnum? _selectedInstitute;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _selectedInstitute!.instituteId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bottom wave background
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: CustomPaint(painter: BottomWavePainter()),
            ),
          ),

          // Main content for Register
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                context.go('/home');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              size: 32,
                              color: Colors.green,
                            ),
                            Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        /// Username
                        AuthTextField(
                          fieldController: _usernameController,
                          label: 'Username',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Username is required'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // Email
                        AuthTextField(
                          fieldController: _emailController,
                          label: 'DNSC Email Address',
                          validator: DnscEmailValidator.dnscEmailValidator,
                        ),

                        const SizedBox(height: 16),

                        // First Name
                        AuthTextField(
                          fieldController: _firstNameController,
                          label: 'First Name',
                          validator: (value) => value == null || value.isEmpty
                              ? 'First name is required'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // Last Name
                        AuthTextField(
                          fieldController: _lastNameController,
                          label: 'Last Name',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Last name is required'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // Institute - Maybe a Dropdown
                        DropdownButtonFormField<InstitutesEnum>(
                          initialValue: _selectedInstitute,
                          decoration: InputDecoration(
                            labelText: 'Institute',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          items: InstitutesEnum.values.map((institute) {
                            return DropdownMenuItem<InstitutesEnum>(
                              value: institute,
                              child: Text(institute.displayName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedInstitute = value;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Please select your institute'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        /// Password
                        AuthTextField(
                          fieldController: _passwordController,
                          label: 'Password',
                          hideText: true,
                          validator: (value) =>
                              value == null || value.length <= 6
                              ? 'Password must be at least 6 characters'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        /// Confirm Password
                        AuthTextField(
                          fieldController: _confirmPasswordController,
                          label: 'Confirm Password',
                          hideText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        /// Register Button
                        AuthButton(
                          onSubmitButton: state is AuthLoading
                              ? null
                              : _onRegisterPressed,
                          stateOnSubmit: state is AuthLoading
                              ? CircularProgressIndicator(
                                  color: Colors.green[900],
                                )
                              : Text("Register"),
                        ),

                        const SizedBox(height: 12),

                        /// Back to login
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.grey[200]),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(color: Colors.grey[100]),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/login');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
