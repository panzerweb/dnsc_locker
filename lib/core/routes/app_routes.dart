import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/login_page.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/profile_page.dart';
import 'package:dnsc_locker/feature/auth/presentation/pages/register_page.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/pages/renting_screen_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/browse_lockers.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/dashboard_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/report/issues_page.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/report/submit_issue_page.dart';
import 'package:dnsc_locker/feature/systems/presentation/pages/systems_page.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/pages/subscription_page.dart';
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
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: UniqueKey(), // Triggers rebuild on every visit
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),

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
          routes: <GoRoute>[
            /*

              When dynamic, we can pass a parameter for the
              specific locker subscription entity

              I think we can use the 'extra' for it
            */
            GoRoute(
              path: 'current_subscription',
              builder: (context, state) => SubscriptionPage(),
            ),
            /*
              Submitting an issue regarding the locker
              We can pass a locker id from subscription
              to automatically identify the specific locker

              I think we can use the 'extra' for it
            */
            GoRoute(
              path: 'submit_issue',
              builder: (context, state) => SubmitIssuePage(),
            ),
            GoRoute(path: 'issues', builder: (context, state) => IssuesPage()),
          ],
        ),

        /*
          Routes outside the dashboard route
        */
        GoRoute(
          path: '/browse',
          builder: (context, state) => BrowseLockers(),
          routes: <GoRoute>[
            GoRoute(
              path: 'locker/:lockerId',
              builder: (context, state) => RentingScreenPage(
                lockerId: state.pathParameters['lockerId']!,
              ),
            ),
          ],
        ),
        GoRoute(path: '/systems', builder: (context, state) => SystemsPage()),
      ],
    ),
  ],
);
