import 'package:dnsc_locker/core/helper/get_initials.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/*
  COMPONENT FOLDER: Common widgets that are reusable to the entire application

  Main appbar for appbar argument in the 
  Scaffold widget as a PreferredSizeWidget

  Note:
    Leading should be the official logo of the app

    Title can be the App name, or a tab's title

    Actions should have a Profile button that leads to a route for profile
    page.


  Usage:
    appbar: ScaffoldAppBar(title: string),
*/

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? username;
  // final VoidCallback? onProfileUpdate;

  const MainAppbar({
    super.key,
    required this.title,
    this.username,
    // this.onProfileUpdate,
  });

  @override
  State<MainAppbar> createState() => _MainAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadCurrentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.secondaryColor,
      foregroundColor: Palette.lightShadePrimary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(Icons.school, size: 32),
      ),
      centerTitle: true,
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(color: Palette.lightShadePrimary, fontSize: 18),
        ),
      ),
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedUserLoaded) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.push('/profile');
                  },
                  splashColor: Palette.darkShadePrimary,
                  child: CircleAvatar(
                    backgroundColor: Palette.accentColor,
                    child: Text(
                      GetInitials.getInitials(
                        '${user.first_name} ${user.last_name}',
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        // IconButton(
        //   onPressed: () {
        //     context.push('/profile');
        //   },
        //   icon: Icon(Icons.person),
        // ),
      ],
    );
  }
}
