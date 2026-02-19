import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_page_header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_filter_dialog.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  final _scrollController = ScrollController();
  List<LockerEntity> lockers = [];
  bool hasSelected = false;

  @override
  void initState() {
    super.initState();

    context.read<LockerCubit>().loadLockers();

    _scrollController.addListener(() {
      final cubit = context.read<LockerCubit>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (!cubit.state.isFiltered) {
          cubit.loadLockers();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /*
    The Widget for the Browse Lockers page
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'Browse Lockers'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthError) {
              return AuthUserError(message: state.message);
            }

            if (state is AuthenticatedUserLoaded) {
              final user = state.user;
              debugPrint("You loaded Browse Locker");
              print("Loaded User: ${user.username}");

              /*
                  The filterer, change the logic here to filter out
                  what you want to filter base on the fields
                  of the entity of the locker
                */

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BrowsePageHeaderSection(
                        instituteDetailName:
                            user.institute?.instituteName ?? 'No Institute',
                      ),

                      // Button to filter lockers base on academic year and semester and building
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => const LockerFilterDialog(),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                          foregroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        child: Row(
                          spacing: 4,
                          children: [Icon(Icons.filter_list)],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /*  
                      Returns the Blocbuilder for the lockers
                    */
                  Expanded(
                    child: BlocBuilder<LockerCubit, LockerState>(
                      builder: (context, state) {
                        if (state.isLoading && state.lockers.isEmpty) {
                          return const CircularProgressIndicator(
                            color: Palette.accentColor,
                          );
                        }
                        if (state.error == true) {
                          return const Center(
                            child: Text("Something is wrong fetching lockers"),
                          );
                        }

                        if (state.lockers.isEmpty) {
                          return const Center(
                            child: EmptyListText(
                              title: 'No Lockers',
                              message: 'There are no available lockers',
                              icon: Icons.apartment,
                            ),
                          );
                        }
                        if (state.isFiltered == true) {
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.hasReachedMax
                                ? state.lockers.length
                                : state.lockers.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= state.lockers.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final locker = state.lockers[index];
                              return LockerCard(locker: locker);
                            },
                          );
                        } else {
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.hasReachedMax
                                ? state.lockers.length
                                : state.lockers.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= state.lockers.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final locker = state.lockers[index];
                              return LockerCard(locker: locker);
                            },
                          );
                        }

                        // print(buildings);
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
