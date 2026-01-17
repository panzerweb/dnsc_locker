import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/login_page.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/register_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/dashboard_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/settings_page.dart';
import 'package:dnsc_locker/home_screen.dart';
import 'package:dnsc_locker/main_interface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: '/',
  /*

    Redirection routing for authentication and authorization
    purposes, but you can use external redirection as well
    for more layer of security.

  */
  redirect: (BuildContext context, GoRouterState state) async {
    final tokenService = locator<TokenService>();
    final isLoggedIn = await tokenService.getToken() != null;

    final isAuthRoute =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    if (!isLoggedIn && state.matchedLocation == '/dashboard') {
      return '/';
    }
    if (isLoggedIn && isAuthRoute) {
      return '/dashboard';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    /*

      Shellroute for all the routes within the BottomNavigationBar

    */
    ShellRoute(
      builder: (context, state, child) {
        return MainInterface(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(path: '/browse', builder: (context, state) => BrowseLockers()),
        GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
      ],
    ),
  ],
);
