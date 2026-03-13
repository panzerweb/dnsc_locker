import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/helper/current_academic_year.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/active_locker_cubit.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/active_locker_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/no_active_locker_card.dart';
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
  void initState() {
    super.initState();

    context.read<ActiveLockerCubit>().loadActiveLockerSubscriptions();
  }

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
                // print(user);
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
                    BlocBuilder<ActiveLockerCubit, ActiveLockerState>(
                      builder: (context, state) {
                        if (state is ActiveLockerLoading) {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (state is ActiveLockerLoaded) {
                          final ActiveLockerSubscriptionEntity? latest =
                              state.latestSubscription;
                          final String currentAcademicYear = getAcademicYear();

                          if (latest == null) {
                            return Center(
                              child: Text(
                                "No Active Locker Subscription",
                                style: TextStyle(
                                  color: Palette.darkShadePrimary,
                                  fontSize: 22,
                                ),
                              ),
                            );
                          }

                          if (latest.academicYear != currentAcademicYear) {
                            return NoActiveLockerCard(
                              activeLockerSubscriptionEntity: latest,
                            );
                          }

                          return ActiveLockerCard(
                            activeLockerSubscriptionEntity: latest,
                          );
                        }

                        if (state is ActiveLockerError) {
                          print(state.message);
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: Palette.darkShadePrimary,
                                fontSize: 22,
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),

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
                            context.push('/dashboard/locker_requests/');
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
