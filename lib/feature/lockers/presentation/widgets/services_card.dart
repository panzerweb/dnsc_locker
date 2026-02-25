import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onTapped;

  const ServicesCard({
    super.key,
    required this.label,
    required this.icon,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTapped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: Palette.accentColor, size: 36),
            Text(
              label,
              style: TextStyle(
                color: Palette.darkShadePrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
