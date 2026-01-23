import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:flutter/material.dart';

class LockerCard extends StatelessWidget {
  final LockerEntity locker;
  const LockerCard({super.key, required this.locker});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
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
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.lock, size: 24),
            ),

            const SizedBox(width: 12),

            // CENTER INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Locker number
                  Text(
                    'Locker ${locker.lockerNo}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Building + floor
                  Row(
                    children: [
                      const Icon(Icons.apartment, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${locker.building.name} · Floor ${locker.building.floors}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Institute
                  if (locker.building.institute != null)
                    Row(
                      children: [
                        const Icon(Icons.school, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          locker.building.institute!.instituteName,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
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
                // TODO: navigate to locker detail / reserve
              },
              icon: Icon(Icons.add_circle_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
