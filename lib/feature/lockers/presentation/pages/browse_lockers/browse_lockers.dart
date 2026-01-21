import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/building_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/institute_entity.dart';
import 'package:dnsc_locker/feature/lockers/domain/entities/locker_entity.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_page_header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/locker_card.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/no_selected_building.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  ),
  LockerEntity(
    id: 2,
    lockerNo: '450',
    building: BuildingEntity(
      name: 'ITED Building',
      floors: 1,
      institute: InstituteEntity(
        id: 2,
        instituteName: 'Institute of Teachers Education',
      ),
    ),
  ),
  LockerEntity(
    id: 1,
    lockerNo: '100',
    building: BuildingEntity(
      name: 'Academic Building',
      floors: 1,
      institute: InstituteEntity(
        id: 2,
        instituteName: 'Institute of Teachers Education',
      ),
    ),
  ),
];

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  String selectedLockers = '';
  bool hasSelected = false;
  /*
  
    Show buildings of an institute

    Dynamic data must come from the building fields
    of the Lockers table per institute

  */

  Future<LockerEntity?> _showBuilding(int instituteId) async {
    return showDialog<LockerEntity>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        /*
          Display buildings base on Institute of the Logged in user
        */
        final buildingsBaseOnInstitute = mockLockerData.where((building) {
          return building.building.institute!.id == instituteId;
        }).toList();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          backgroundColor: Colors.white,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Row(
                    children: const [
                      Icon(Icons.apartment, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Select Building',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // List
                Expanded(
                  child: ListView.separated(
                    itemCount: buildingsBaseOnInstitute.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final locker = buildingsBaseOnInstitute[index];

                      return ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(locker.building.name),
                        subtitle: Text('${locker.building.floors} floors'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          setState(() {
                            selectedLockers = locker.building.name;
                            hasSelected = true;
                            Navigator.of(context).pop(locker);
                          });
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

              /*
                The filterer, change the logic here to filter out
                what you want to filter base on the fields
                of the entity of the locker
              */
              final filteredLockers = mockLockerData.where((locker) {
                //Return base on institute -- Uncomment line below if you want this logic
                // return locker.building.institute!.id == instituteId;

                // Return  base on building name -- Uncomment line below if you want this logic
                return locker.building.name == selectedLockers;
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
                          await _showBuilding(user.institute!.id);
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
                  // If you have not selected a building
                  if (hasSelected == false) NoSelectedBuilding(),

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

                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Lockers for $selectedLockers",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.darkShadePrimary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          LockerCard(locker: locker),
                        ],
                      );
                    },
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
