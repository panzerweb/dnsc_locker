import 'dart:convert';

import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_page_header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_filter_dialog.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  final _scrollController = ScrollController();
  Map<String, dynamic> filterValues = {
    "academic_year": "",
    "building": 0,
    "semester": "",
    "building_name": "",
  };

  @override
  void initState() {
    super.initState();
    _loadFilterValues();

    // context.read<LockerCubit>().loadLockers();

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

  Future<Map<String, dynamic>> _getFilterValuesMap() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('filter_values');
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return {};
  }

  Future<void> _saveFilterValues(Map<String, dynamic> filters) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(filters);

    await prefs.setString('filter_values', jsonString);
  }

  Future<void> _loadFilterValues() async {
    final map = await _getFilterValuesMap();

    if (!mounted) return;

    setState(() {
      filterValues = {
        "academic_year": "",
        "building": 0,
        "semester": "",
        "building_name": "",
        ...map, // override defaults
      };
    });

    if (map.isNotEmpty && map["academic_year"] != "" && map["semester"] != "") {
      context.read<LockerCubit>().loadAvailableLockers(
        academicYear: map["academic_year"],
        building: map["building"],
        semester: map["semester"],
      );
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        onPressed: () async {
                          final dialogResult = await showDialog(
                            context: context,
                            builder: (_) => const LockerFilterDialog(),
                          );

                          if (dialogResult != null) {
                            setState(() {
                              filterValues = Map<String, dynamic>.from(
                                dialogResult,
                              );

                              _saveFilterValues(filterValues);

                              print(filterValues);
                            });
                          }
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
                          children: [Icon(Icons.filter_list)],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /*  
                      Returns the Blocbuilder for the lockers
                  */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Chip(
                          avatar: const Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            "AY ${filterValues['academic_year']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue.shade200),
                          ),
                        ),
                        Chip(
                          avatar: const Icon(Icons.school, size: 18),
                          label: Text(
                            filterValues['semester'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          backgroundColor: Colors.green.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.green.shade200),
                          ),
                        ),
                        Chip(
                          avatar: const Icon(Icons.apartment, size: 18),
                          label: Text(
                            filterValues['building_name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          backgroundColor: Colors.yellow.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.yellow.shade200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<LockerCubit, LockerState>(
                      builder: (context, state) {
                        if (state.isLoading && state.lockers.isEmpty) {
                          return Center(
                            child: const CircularProgressIndicator(
                              color: Palette.accentColor,
                            ),
                          );
                        }
                        if (state.error == true) {
                          return const Center(
                            child: EmptyListText(
                              title: 'Something is wrong!',
                              message:
                                  'Check your internet connection or contact admin for info.',
                              icon: Icons.apartment,
                            ),
                          );
                        }

                        if (state.lockers.isEmpty &&
                            state.isFiltered == false) {
                          return const Center(
                            child: EmptyListText(
                              title: 'No Lockers',
                              message:
                                  'Select some filter options to view lockers',
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
                              return LockerCard(
                                locker: locker,
                                filterValues: filterValues,
                              );
                            },
                          );
                        } else {
                          return EmptyListText(
                            title: 'Found Nothing!',
                            message: 'Failed to return lockers.',
                            icon: Icons.apartment,
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
