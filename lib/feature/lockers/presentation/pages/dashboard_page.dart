import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_indicator_row.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/active_locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/related_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadCurrentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'DNSC LRMS'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedUserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthenticatedUserLoaded) {
              final user = state.user;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderSection(user: user),

                  const SizedBox(height: 12),

                  /* 

                    Widget for accepting if the locker subscription
                    is active or not

                    Shall accepts params in the future like:

                      ActiveIndicatorRow(status: subStatus)

                    Where subStatus is an Entity with an API response

                  */
                  ActiveIndicatorRow(),

                  const SizedBox(height: 12),

                  /*

                    Widget for the current active locker subscription
                    of the user.

                    Shows conditional rendering that if there is an active
                    subscription, then show Widget()

                    Else, show anotherWidget or pass a condition in the same
                    Widget

                  */
                  ActiveLockerCard(),

                  const SizedBox(height: 12),

                  /*

                    Widgets for related data that must be shown
                    within the app such as rent fee of the current
                    locker subscription or the current academic year.

                    You can add more if you want.

                    If no data is shown, you can pass conditionally
                    render a widget or pass a conditional rendering
                    on the same widget itself

                  */
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.6,
                    children: const [
                      RelatedDetailCard(
                        icon: Icons.attach_money,
                        label: 'Rent Fee',
                        data: '30.00',
                      ),
                      RelatedDetailCard(
                        icon: Icons.school_rounded,
                        label: 'A.Y. 2025 - 2026',
                        data: 'Second Semester',
                      ),
                    ],
                  ),
                ],
              );
            }

            if (state is AuthenticatedUserError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
