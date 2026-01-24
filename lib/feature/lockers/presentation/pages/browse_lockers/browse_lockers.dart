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
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  String selectedBuilding = '';
  bool hasSelected = false;

  @override
  void initState() {
    super.initState();

    context.read<LockerCubit>().loadLockers();
  }

  /*
  
    Show buildings of an institute

    Dynamic data must come from the building fields
    of the Lockers table per institute

  */

  /*
    The Widget for the Browse Lockers page
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'Browse Lockers'),
      body: SingleChildScrollView(
        child: Padding(
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

                        // Button to select building
                        ElevatedButton(
                          onPressed: () {
                            print('Clicked');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            foregroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          child: Row(
                            spacing: 4,
                            children: [
                              Icon(Icons.search_sharp),
                              Text("Find Building"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /*  
                      Returns the Blocbuilder for the lockers
                    */
                    BlocBuilder<LockerCubit, LockerState>(
                      builder: (context, state) {
                        if (state is LockerLoading) {
                          return const CircularProgressIndicator(
                            color: Palette.accentColor,
                          );
                        }
                        if (state is LockerError) {
                          return const Center(
                            child: Text("Something is wrong fetching lockers"),
                          );
                        }

                        if (state is LockerLoaded) {
                          final lockers = state.lockers;

                          return ListView.builder(
                            itemCount: lockers.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final locker = lockers[index];

                              return LockerCard(locker: locker);
                            },
                          );
                        }

                        return const SizedBox.shrink();
                        // print(buildings);
                      },
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
