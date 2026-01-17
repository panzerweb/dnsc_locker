import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class ActiveLockerCard extends StatelessWidget {
  const ActiveLockerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Palette.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔒 Lock Icon Container
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.lock_person_rounded,
                size: 56,
                color: Palette.accentColor,
              ),
            ),

            const SizedBox(width: 16),

            // 🏷 Locker Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Locker No.",
                    style: TextStyle(
                      letterSpacing: 0.8,
                      color: Palette.lightShadeSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "245",
                    style: TextStyle(
                      fontSize: 48,
                      letterSpacing: 0.8,
                      color: Palette.lightShadePrimary,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),

            // ⚙ Actions
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.fullscreen,
                  color: Palette.lightShadeSecondary,
                  size: 32,
                ),
                const SizedBox(height: 32),
                Icon(Icons.info, color: Palette.darkShadePrimary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
