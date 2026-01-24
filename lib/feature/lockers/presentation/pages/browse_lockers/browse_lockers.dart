import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/institute_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_page_header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/empty_list_text.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Mock data
final List<LockerEntity> mockLockerData = [
  LockerEntity(
    id: 1,
    lockerNo: '213',
    building: BuildingEntity(
      name: 'IC Building',
      floors: 1,
      institute: InstituteEntity(
        id: 1,
        instituteName: 'Institute of Computing',
      ),
    ),
    isRented: 1,
    status: 0,
  ),
  LockerEntity(
    id: 2,
    lockerNo: '215',
    building: BuildingEntity(
      name: 'IC Building',
      floors: 1,
      institute: InstituteEntity(
        id: 1,
        instituteName: 'Institute of Computing',
      ),
    ),
    isRented: 0,
    status: 0,
  ),
  LockerEntity(
    id: 3,
    lockerNo: '450',
    building: BuildingEntity(
      name: 'IC Building',
      floors: 2,
      institute: InstituteEntity(
        id: 1,
        instituteName: 'Institute of Computing',
      ),
    ),
    isRented: 0,
    status: 0,
  ),
  LockerEntity(
    id: 4,
    lockerNo: '470',
    building: BuildingEntity(
      name: 'IC Lounge',
      floors: 1,
      institute: InstituteEntity(
        id: 1,
        instituteName: 'Institute of Computing',
      ),
    ),
    isRented: 0,
    status: 0,
  ),
];

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  String selectedBuilding = '';
  bool hasSelected = false;
  /*
  
    Show buildings of an institute

    Dynamic data must come from the building fields
    of the Lockers table per institute

  */

  Future<List<LockerEntity>?> _showBuilding(int instituteId) async {
    return showDialog<List<LockerEntity>>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final buildingsBaseOnInstitute = mockLockerData.where((locker) {
          return locker.building.institute!.id == instituteId;
        }).toList();

        // Create a map and put the building name as the key
        // While lockers base on the institute
        final Map<String, List<LockerEntity>> lockersByBuilding = {};

        for (var locker in buildingsBaseOnInstitute) {
          final buildingName = locker.building.name;

          lockersByBuilding.putIfAbsent(buildingName, () => []);
          lockersByBuilding[buildingName]!.add(locker);
        }

        final buildings = lockersByBuilding.entries.toList();

        // print(buildings);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 420, minWidth: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Row(
                    children: [
                      Icon(Icons.apartment, color: Palette.darkShadePrimary),
                      const SizedBox(width: 8),
                      Text(
                        "Buildings",
                        style: TextStyle(
                          color: Palette.darkShadePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                if (buildings.isEmpty)
                  EmptyListText(
                    title: 'No available buildings',
                    message:
                        'There are no fetched building data for this institute',
                    height: 24,
                    icon: Icons.apartment_outlined,
                  ),

                // List
                Expanded(
                  child: ListView.separated(
                    itemCount: buildings.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = buildings[index];
                      final buildingName = entry.key;
                      final lockers = entry.value;
                      final building = lockers.first.building;

                      return ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(buildingName),
                        subtitle: Text(
                          '${building.floors} floors • ${lockers.length} lockers',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          context.pop(lockers);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

                /*
                  The filterer, change the logic here to filter out
                  what you want to filter base on the fields
                  of the entity of the locker
                */
                final filteredLockers = mockLockerData.where((locker) {
                  //Return base on institute -- Uncomment line below if you want this logic
                  // return locker.building.institute!.id == instituteId;

                  // Return  base on building name -- Uncomment line below if you want this logic
                  return locker.building.name == selectedBuilding;
                }).toList();

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BrowsePageHeaderSection(
                          instituteDetailName: user.institute!.instituteName,
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            final selectedLockers = await _showBuilding(
                              user.institute!.id,
                            );

                            if (selectedLockers == null ||
                                selectedLockers.isEmpty)
                              return;

                            setState(() {
                              selectedBuilding =
                                  selectedLockers.first.building.name;
                              hasSelected = true;
                            });
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

                    /*
        
                      The widget below will be for the corresponding
                      building of the lockers per institute_id
        
                    */
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          hasSelected != false
                              ? "Lockers for $selectedBuilding"
                              : "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Palette.darkShadePrimary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),

                    // If you have not selected a building
                    if (hasSelected == false)
                      EmptyListText(
                        title: 'Select Building',
                        message: 'Choose a building to view available lockers',
                        height: 64,
                        icon: Icons.apartment_outlined,
                      ),

                    /*
                      Else, show a BlocBuilder for the Lockers
        
                      For now, we will use ListView
                      for the mock data
        
                      The widgets below will be the list
                      of lockers that are associated with the
                      user's institute_id
        
                      match the institute_id of user
                      to the institute_id of lockers
        
                    */
                    ListView.builder(
                      itemCount: filteredLockers.length,
                      padding: const EdgeInsets.only(top: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final locker = filteredLockers[index];

                        return LockerCard(locker: locker);
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
