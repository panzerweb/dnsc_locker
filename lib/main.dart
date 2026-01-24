import 'package:dnsc_locker/core/routes/app_routes.dart';
import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load ENV file
  // PORT IS 49181
  try {
    await dotenv.load(fileName: ".env");

    // print(dotenv.env); // DEBUG
    // print(dotenv.get('DJANGO_API_URL', fallback: 'MISSING'));
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => locator<AuthCubit>()..loadCurrentProfile(),
        ),
        BlocProvider<LockerCubit>(create: (_) => locator<LockerCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DNSC LRMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerConfig: router, // Access router in the application
    );
  }
}
