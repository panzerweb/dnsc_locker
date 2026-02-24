import 'package:dnsc_locker/core/helper/get_initials.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final UserEntity user;
  const HeaderSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // User personal informations
    final userFirstName = user.student?.firstName ?? 'Guest';
    final userLastName = user.student?.lastName ?? 'LastName';
    final instituteDetailName = user.institute?.instituteName ?? 'No Institute';
    final userStudentId = user.student?.studentId ?? '0000-00000';

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Palette.secondaryColor,
                  child: Text(
                    GetInitials.getInitials('$userFirstName $userLastName'),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Palette.lightShadePrimary,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// Text Info
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back, $userFirstName 👋",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Palette.darkShadePrimary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        instituteDetailName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.darkShadeSecondary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Student ID badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.secondaryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "ID: $userStudentId",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Palette.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
