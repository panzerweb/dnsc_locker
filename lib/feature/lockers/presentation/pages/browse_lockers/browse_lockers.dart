import 'package:dnsc_locker/core/components/main_appbar.dart';
import 'package:dnsc_locker/core/constant/locker_status_enum.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/browse_lockers/widgets/browse_page_header_section.dart';
import 'package:dnsc_locker/feature/lockers/presentation/widgets/auth_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Enums for the locker status

final Map<LockerStatusEnum, String> lockerStatus = {
  LockerStatusEnum.all: 'All',
  LockerStatusEnum.available: 'Available',
  LockerStatusEnum.unavailable: 'Unavailable',
};

class BrowseLockers extends StatefulWidget {
  const BrowseLockers({super.key});

  @override
  State<BrowseLockers> createState() => _BrowseLockersState();
}

class _BrowseLockersState extends State<BrowseLockers> {
  // Selected options for locker status to filter
  // Apply maybe a switch statement,to filter lockers
  // And add to a new array of filtered lockers
  LockerStatusEnum? _selectedOption = LockerStatusEnum.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: 'Browse Lockers'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedUserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthenticatedUserError) {
              return AuthUserError(message: state.message);
            }

            if (state is AuthenticatedUserLoaded) {
              final user = state.user;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BrowsePageHeaderSection(
                        instituteDetailName: user.institute!.instituteName,
                      ),

                      /*

                        This section will be for the dropdown menu
                        to filter lockers base on its status

                      */
                      DropdownMenu<LockerStatusEnum>(
                        initialSelection: _selectedOption,
                        enableSearch: false, // compact = no search
                        textStyle: TextStyle(
                          color: Palette.lightShadePrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Palette.accentColor,
                          ),
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          isDense: true,
                          filled: true,
                          fillColor: Palette.accentColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        trailingIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: Palette.lightShadePrimary,
                        ),
                        onSelected: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                        dropdownMenuEntries: lockerStatus.entries.map((locker) {
                          return DropdownMenuEntry<LockerStatusEnum>(
                            value: locker.key,
                            label: locker.value,
                            leadingIcon: Icon(
                              Icons.dns_outlined,
                              size: 16,
                              color: Palette.lightShadePrimary,
                            ),
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(
                                Palette.lightShadePrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  /*

                    The widget below will be the list
                    of lockers that are associated with the
                    user's institute_id

                    match the institute_id of user
                    to the institute_id of lockers

                  */
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
