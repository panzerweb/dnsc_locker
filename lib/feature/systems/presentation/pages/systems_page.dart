import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:flutter/material.dart';

class SystemsPage extends StatelessWidget {
  const SystemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'Under Development'),
      body: Center(
        child: EmptyListText(
          title: "Page Not Available",
          message: "This page is still under development",
          icon: Icons.build_circle,
        ),
      ),
    );
  }
}
