import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final UserEntity user;
  const HeaderSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userFirstName = user.firstName ?? 'Guest';
    final instituteDetailName = user.institute?.instituteName ?? 'No Institute';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome, $userFirstName",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Palette.darkShadePrimary,
          ),
        ),
        Text(
          instituteDetailName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Palette.darkShadeSecondary,
          ),
        ),
      ],
    );
  }
}
