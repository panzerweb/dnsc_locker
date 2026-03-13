import 'package:dnsc_locker/core/helper/format_date.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/locker_subscription/domain/entities/active_locker_subscription_entity.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/widgets/sub_details_tile.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  final ActiveLockerSubscriptionEntity activeLocker;

  const SubscriptionPage({super.key, required this.activeLocker});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    final String? activeFee = widget.activeLocker.fee?.balance;
    final String? fullName = widget.activeLocker.student?.fullName;
    final String paymentDue = widget.activeLocker.paymentDueAt;

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
                    'Locker No. ${widget.activeLocker.locker?.lockerNumber}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Palette.lightShadePrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.apartment,
                        size: 18,
                        color: Palette.lightShadeSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.activeLocker.locker?.building.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.lightShadeSecondary,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Icon(
                        Icons.layers,
                        size: 18,
                        color: Palette.lightShadeSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.activeLocker.locker?.floor} Floor',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.lightShadeSecondary,
                        ),
                      ),
                    ],
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
                  children: [
                    SubDetailsTile(
                      leading: Icon(Icons.calendar_month),
                      title: 'Last Subscription',
                      subtitle: widget.activeLocker.subscribedAt,
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.info),
                      title: 'Payment Status',
                      subtitle: widget.activeLocker.paymentStatus == 'unpaid'
                          ? 'Unpaid'
                          : 'Paid',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.attach_money),
                      title: 'Rental Fee',
                      subtitle: activeFee ?? 'Not Set',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.person),
                      title: 'Renter',
                      subtitle: fullName ?? 'Not Set',
                    ),
                    SubDetailsTile(
                      leading: Icon(Icons.calendar_month),
                      title: 'Payment Due',
                      subtitle: formatDate(paymentDue),
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
