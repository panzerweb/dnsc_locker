import 'package:dnsc_locker/feature/locker_subscription/domain/entities/locker_subscription_request_entity.dart';
import 'package:flutter/material.dart';

class RequestsListTile extends StatelessWidget {
  final int index;
  final LockerSubscriptionRequestEntity requestEntity;
  final VoidCallback? onDelete; // callback for delete button

  const RequestsListTile({
    super.key,
    required this.index,
    required this.requestEntity,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    // Determine badge color based on status
    switch (requestEntity.status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green.shade600;
        break;
      case 'pending':
        statusColor = Colors.orange.shade600;
        break;
      case 'rejected':
        statusColor = Colors.red.shade600;
        break;
      default:
        statusColor = Colors.grey.shade600;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading: Circle with index
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                "$index",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "You requested locker number ${requestEntity.locker?.lockerNumber ?? 'N/A'}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    "Academic Year: ${requestEntity.academicYear}, Semester: ${requestEntity.semester}",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Trailing: status chip + delete button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  label: Text(
                    requestEntity.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  backgroundColor: statusColor,
                ),
                if (requestEntity.status == 'pending') ...[
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
                const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
