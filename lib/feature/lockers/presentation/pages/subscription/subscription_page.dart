import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/lockers/presentation/pages/subscription/widgets/sub_details_tile.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          backgroundColor: Palette.secondaryColor,
          floating: true,
          pinned: false,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dns, size: 48, color: Palette.accentColor),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /*
                    
                    Replace hardcoded values with the locker
                    subscription entity data

                  */
                  Text(
                    'Locker No. 245',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Palette.lightShadePrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'IC Building • 2nd Floor',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.lightShadeSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /*
          Replace hardcoded values with the locker subscription
          entity and other entities that are related to the page
        */
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subscription Details',
                  style: TextStyle(
                    color: Palette.darkShadePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                Column(
                  children: const [
                    SubDetailsTile(
                      leading: Icon(Icons.calendar_month),
                      title: 'Last Subscription',
                      subtitle: 'January 16, 2026',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.info),
                      title: 'Status',
                      subtitle: 'Paid',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.attach_money),
                      title: 'Rental Fee',
                      subtitle: 'Php 100.00',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.person),
                      title: 'Renter',
                      subtitle: 'Romeo Selwyn Villar',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.people),
                      title: 'Institute',
                      subtitle: 'Institute of Computing',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: go to a request page for requesting a change
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Request Changes',
                  style: TextStyle(
                    color: Palette.lightShadePrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
