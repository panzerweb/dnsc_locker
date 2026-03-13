import 'package:dnsc_locker/core/helper/current_academic_year.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoActiveLockerCard extends StatelessWidget {
  final ActiveLockerSubscriptionEntity activeLockerSubscriptionEntity;

  const NoActiveLockerCard({
    super.key,
    required this.activeLockerSubscriptionEntity,
  });

  @override
  Widget build(BuildContext context) {
    final String currentAcademicYear = getAcademicYear();

    return Card(
      elevation: 10,
      color: Palette.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Palette.darkGreenColor.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 40,
                color: Palette.lightShadePrimary,
              ),
            ),

            const SizedBox(height: 16),

            /// Title
            Text(
              "No Active Locker",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.lightShadePrimary,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            /// Current Academic Year
            Chip(
              elevation: 6,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: Palette.darkGreenColor,
              shadowColor: Colors.black,
              label: Text(
                "Current A.Y. $currentAcademicYear",
                style: TextStyle(
                  color: Palette.lightShadeSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// Description
            Text(
              "You don't currently have a locker subscription for this academic year.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.lightShadeSecondary,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            /// Optional Action Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.darkGreenColor,
                foregroundColor: Colors.white,
                elevation: 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.keyboard_double_arrow_right),
              label: const Text(
                "Browse some lockers",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                context.go('/browse');
              },
            ),
          ],
        ),
      ),
    );
  }
}
