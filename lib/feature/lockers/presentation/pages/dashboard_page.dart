import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_indicator_row.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/related_detail_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'DNSC LRMS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AuthenticatedUserLoaded) {
                final user = state.user;
                print("You loaded dashboard");
                print(user);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(user: user),

                    const SizedBox(height: 12),

                    /*
        
                      Widget for the current active locker subscription
                      of the user.
        
                      Shows conditional rendering that if there is an active
                      subscription, then show Widget()
        
                      Else, show anotherWidget or pass a condition in the same
                      Widget

                      Update: Will show the total balance, what locker is
        
                    */
                    ActiveLockerCard(),

                    const SizedBox(height: 14),

                    /*
        
                      Widgets for different services of the application.
                      You can add more if you want.
        
                      If no data is shown, you can pass conditionally
                      render a widget or pass a conditional rendering
                      on the same widget itself
        
                    */
                    Text(
                      "Services",
                      style: TextStyle(
                        color: Palette.darkShadePrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.6,
                      children: [
                        ServicesCard(
                          label: "Payment",
                          icon: Icons.payment,
                          onTapped: () {
                            print("Go to Payment Service");
                          },
                        ),
                        ServicesCard(
                          label: "Reports",
                          icon: Icons.article,
                          onTapped: () {
                            context.push('/dashboard/issues/');
                          },
                        ),
                        ServicesCard(
                          label: "Analytics",
                          icon: Icons.analytics,
                          onTapped: () {
                            print("Go to Analytics Service");
                          },
                        ),
                        ServicesCard(
                          label: "Requests",
                          icon: Icons.file_upload,
                          onTapped: () {
                            print("Go to Request Service");
                          },
                        ),
                        ServicesCard(
                          label: "Portal",
                          icon: Icons.person_4_rounded,
                          onTapped: () {
                            print("Go to Student Portal");
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }

              if (state is AuthError) {
                return AuthUserError(message: state.message);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
