import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/reports/presentation/widgets/issue_card.dart';
import 'package:flutter/material.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary mock data
    final issues = [
      {
        "locker": "Locker A-101",
        "message": "Locker door is not closing properly.",
        "date": "March 1, 2026",
        "status": "Pending",
      },
      {
        "locker": "Locker B-202",
        "message": "Lock mechanism is stuck.",
        "date": "February 27, 2026",
        "status": "Resolved",
      },
    ];

    return Scaffold(
      appBar: PushedAppbar(title: 'My Submitted Issues'),
      body: issues.isEmpty
          ? EmptyListText(
              title: "No issues submitted yet.",
              message:
                  "If you encounter a problem with your locker, you can submit a report.",
              icon: Icons.report_problem_outlined,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: issues.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final issue = issues[index];

                return IssueCard(
                  locker: issue["locker"]!,
                  message: issue["message"]!,
                  date: issue["date"]!,
                  status: issue["status"]!,
                );
              },
            ),
    );
  }
}
