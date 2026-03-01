import 'package:flutter/material.dart';

class ReminderBannerCard extends StatelessWidget {
  const ReminderBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Please keep your report respectful and professional. "
              "Avoid offensive language or personal attacks. "
              "Reports containing inappropriate content may not be processed.",
              style: TextStyle(fontSize: 14, color: Colors.orange.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
