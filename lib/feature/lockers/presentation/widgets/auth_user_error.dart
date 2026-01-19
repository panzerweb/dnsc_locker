import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class AuthUserError extends StatelessWidget {
  final String message;
  const AuthUserError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Palette.darkShadePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          Text(
            "Please check your internet connection or contact admin for information",
            style: TextStyle(color: Palette.darkShadeSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
