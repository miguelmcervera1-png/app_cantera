import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/trip_provider.dart';
import '../widgets/offer_ride_sheet.dart';
import '../widgets/trip_card.dart';

class CarpoolingScreen extends ConsumerWidget {
  const CarpoolingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final trips = ref.watch(tripProvider);
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/espanyol_logo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.navCarpool, style: const TextStyle(fontSize: 16)),
                Text(
                  auth.userTeam,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.accentGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: trips.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor:
                        AppTheme.primaryBlue.withValues(alpha: 0.06),
                    child: Icon(
                      Icons.directions_car_outlined,
                      size: 48,
                      color: AppTheme.primaryBlue.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noTripsAvailable,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return TripCard(
                  trip: trip,
                  onRequestSeat: () {
                    ref
                        .read(tripProvider.notifier)
                        .requestSeat(trip.tripId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.seatRequested)),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
        onPressed: () async {
          final result = await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => const OfferRideSheet(),
          );
          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.ridePublished)),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.offerRide),
      ),
    );
  }
}
