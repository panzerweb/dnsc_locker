import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class DashboardButtons extends StatelessWidget {
  final void Function()? buttonPressed;
  final WidgetStateProperty<Color?> backgroundColor;
  final WidgetStateProperty<Color?> foregroundColor;
  final String textLabel;
  final Icon icon;

  const DashboardButtons({
    super.key,
    required this.buttonPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textLabel,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: buttonPressed,
      style: ButtonStyle(
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor,
      ),
      icon: icon,
      label: Text(
        textLabel,
        style: TextStyle(color: Palette.lightShadeSecondary),
      ),
    );
  }
}
