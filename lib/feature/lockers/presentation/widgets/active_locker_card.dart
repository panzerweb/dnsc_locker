import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton.outlined(
                  onPressed: () {
                    context.push('/dashboard/current_subscription');
                  },
                  icon: Icon(
                    Icons.fullscreen,
                    color: Palette.lightShadeSecondary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 32),

                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/dashboard/submit_issue');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Palette.secondaryColor,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      Palette.lightShadeSecondary,
                    ),
                  ),
                  icon: Icon(Icons.info, size: 24),
                  label: Text('Report an issue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
