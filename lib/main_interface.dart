import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  Defines the bottom navigation bar
*/

class MainInterface extends StatelessWidget {
  final Widget child;

  const MainInterface({super.key, required this.child});

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/browse')) return 1;
    if (location.startsWith('/settings')) return 2;

    return 0;
  }

  void _onTap(BuildContext context, int index) async {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/browse');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.secondaryColor,
        fixedColor: Palette.lightShadePrimary,
        unselectedItemColor: Palette.accentColor,
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.dns), label: "Browse"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
