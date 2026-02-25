import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LockerCard extends StatelessWidget {
  final LockerEntity locker;
  final Map<String, dynamic> filterValues;
  // Filtered fields such as Academic Year
  const LockerCard({
    super.key,
    required this.locker,
    required this.filterValues,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: Palette.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT ICON
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: locker.isActive != false
                    ? Palette.secondaryColor
                    : Palette.darkShadeSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: locker.isActive != false
                  ? Icon(
                      Icons.check_circle_outline_rounded,
                      size: 24,
                      color: Colors.green[800],
                    )
                  : Icon(Icons.lock, size: 24, color: Colors.green[800]),
            ),

            const SizedBox(width: 12),

            // CENTER INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Locker number
                  Text(
                    'Locker ${locker.lockerNumber}',
                    style: const TextStyle(
                      color: Palette.lightShadePrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Building + floor
                  Row(
                    children: [
                      const Icon(
                        Icons.apartment,
                        size: 14,
                        color: Palette.lightShadeSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${locker.building.name} · Floor ${locker.floor}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Palette.lightShadeSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // RIGHT ACTION
            IconButton(
              onPressed: () {
                locker.isActive != false
                    ? context.push(
                        '/browse/locker/${locker.id}',
                        extra: filterValues,
                      )
                    : null;
              },
              icon: locker.isActive != false
                  ? Icon(
                      Icons.add_circle_outline_rounded,
                      size: 28,
                      color: Palette.secondaryColor,
                    )
                  : Icon(
                      Icons.disabled_visible_sharp,
                      size: 28,
                      color: Palette.secondaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
