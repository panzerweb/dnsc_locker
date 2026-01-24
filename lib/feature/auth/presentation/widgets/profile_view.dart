import 'package:dnsc_locker/core/helper/get_initials.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/auth/domain/entities/user_entity.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/auth/presentation/widgets/profile_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  final UserEntity user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _ProfileHeader(user: user),
        _ProfileDetails(user: user),
        _LogoutButton(),
      ],
    );
  }
}

/*

  BELOW ARE THE DIFFERENT WIDGETS USED

*/

class _ProfileHeader extends StatelessWidget {
  final UserEntity user;

  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Palette.secondaryColor,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Palette.accentColor,
                  child: Text(
                    GetInitials.getInitials(
                      '${user.firstName} ${user.lastName}',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${user.firstName} ${user.lastName}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Palette.lightShadePrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '@${user.username}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Palette.lightShadeSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final UserEntity user;

  const _ProfileDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Details',
              style: TextStyle(
                color: Palette.darkShadePrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ProfileDetailsTile(
              leading: const Icon(Icons.groups_2),
              title: 'Institute',
              subtitle: user.institute?.instituteName ?? 'No Institute',
            ),
            ProfileDetailsTile(
              leading: const Icon(Icons.email),
              title: 'Email Address',
              subtitle: user.email,
            ),
            ProfileDetailsTile(
              leading: Icon(Icons.person),
              title: 'Group',
              subtitle: user.groups.toString(),
            ),

            /*
              If LockerSubscription is available as cubit, then
              call it here

              The logic can be:
              if status is active, then display the code below
            */
            const ProfileDetailsTile(
              leading: Icon(Icons.dns),
              title: 'Locker count',
              subtitle: 'Has 1 active subscription',
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logout();

                context.pushReplacement('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.lightShadePrimary,
                foregroundColor: Palette.darkShadeSecondary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
