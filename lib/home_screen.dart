import 'package:dnsc_locker/core/services/service_locator.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String?> _getToken() {
    return locator<TokenService>().getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FutureBuilder<String?>(
            future: _getToken(),
            builder: (context, snapshot) {
              final isLoggedIn = snapshot.data != null;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🏫 Logo
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 64,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 📌 Title
                  const Text(
                    "DNSC LRMS",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 📖 Subtitle
                  const Text(
                    "DNSC Official Locker Rental Application",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),

                  const SizedBox(height: 40),

                  // 🎯 CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.push(isLoggedIn ? '/dashboard' : '/login');
                      },
                      child: Text(
                        isLoggedIn ? "Go to Dashboard" : "Sign In",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
