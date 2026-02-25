import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_indicator_row.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/dashboard_buttons.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active Subscription",
                  style: TextStyle(
                    color: Palette.lightShadeSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                /*
                  Pass the indicator such as status
                */
                ActiveIndicatorRow(),
              ],
            ),

            const SizedBox(height: 28),

            /*
              Pass the locker number in this widget
            */
            Text(
              "Locker 1",
              style: TextStyle(
                color: Palette.lightShadePrimary,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /*
              Pass the academic year and semester in this widget
            */
            Chip(
              elevation: 8,
              padding: EdgeInsets.all(8),
              backgroundColor: Palette.darkGreenColor,
              shadowColor: Colors.black,
              label: Text(
                "A.Y. 2025 - 2026 | 1st Semester",
                style: TextStyle(color: Palette.lightShadeSecondary),
              ),
            ),

            const SizedBox(height: 12),

            /*
              Pass the balance of the user
            */
            RichText(
              text: TextSpan(
                text: 'Balance: ',
                style: TextStyle(
                  color: Palette.lightShadePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  /*
                    Pass the balance here
                  */
                  TextSpan(
                    text: '₱ 100.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Palette.lightShadeSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /*
              Action Buttons here for viewing the subscription
              and the report issue button
            */
            Card(
              elevation: 8,
              color: Palette.darkGreenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: DashboardButtons(
                        buttonPressed: () {
                          // Pass the id I think of the current_subscription
                          context.push('/dashboard/current_subscription');
                        },
                        backgroundColor: WidgetStatePropertyAll(
                          Palette.darkGreenColor,
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          Palette.lightShadeSecondary,
                        ),
                        textLabel: "View",
                        icon: Icon(
                          Icons.fullscreen,
                          color: Palette.lightShadeSecondary,
                          size: 32,
                        ),
                      ),
                    ),
                    Flexible(
                      child: DashboardButtons(
                        buttonPressed: () {
                          // Pass the id I think of the the current locker
                          context.push('/dashboard/submit_issue');
                        },
                        backgroundColor: WidgetStatePropertyAll(
                          Palette.darkGreenColor,
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          Palette.lightShadeSecondary,
                        ),
                        textLabel: "Report",
                        icon: Icon(
                          Icons.info_outlined,
                          color: Palette.lightShadeSecondary,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
