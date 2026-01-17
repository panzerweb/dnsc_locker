import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

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

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
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
          title,
          style: TextStyle(color: Palette.lightShadePrimary, fontSize: 18),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            null;
            // await context.push('/profile');
            // if (onProfileUpdate != null) {
            //   onProfileUpdate!(); // reload dashboard username
            // }
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
