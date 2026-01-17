import 'package:dnsc_locker/feature/auth/presentation/widgets/auth_button.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/auth_text_field.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/bottom_wave_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
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

          // Main Content for Login
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                context.go('/dashboard');
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
                            Icon(Icons.school, size: 32, color: Colors.green),
                            Text(
                              "Login",
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

                        const SizedBox(height: 24),

                        /// Login Button
                        AuthButton(
                          onSubmitButton: state is AuthLoading
                              ? null
                              : _onLoginPressed,
                          stateOnSubmit: state is AuthLoading
                              ? CircularProgressIndicator(
                                  color: Colors.green[900],
                                )
                              : Text("Login"),
                        ),

                        const SizedBox(height: 12),

                        /// Register navigation
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                            children: [
                              TextSpan(
                                text: "Create one",
                                style: TextStyle(color: Colors.green[500]),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/register');
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
