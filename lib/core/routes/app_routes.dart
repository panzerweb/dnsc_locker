import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/login_page.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/register_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/dashboard_page.dart';
import 'package:dnsc_locker/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) async {
    final tokenService = locator<TokenService>();
    final isLoggedIn = await tokenService.getToken() != null;

    if (!isLoggedIn) {
      return '/login';
    }
    if (isLoggedIn) {
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
    GoRoute(path: '/dashboard', builder: (context, state) => DashboardPage()),
  ],
);
