import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

/*
  COMPONENT FOLDER: Common widgets that are reusable to the entire application

  Pushed appbar for appbar argument in the 
  Scaffold widget as a PreferredSizeWidget

  Note:
    This appbar is not the main appbar but for those
    pages that are identified as nested routes


  Usage:
    appbar: ScaffoldAppBar(title: string),
*/

class PushedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? username;
  // final VoidCallback? onProfileUpdate;

  const PushedAppbar({
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
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
