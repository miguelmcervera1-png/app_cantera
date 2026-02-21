import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/trip_provider.dart';
import '../widgets/offer_ride_sheet.dart';
import '../widgets/trip_card.dart';

class CarpoolingScreen extends ConsumerWidget {
  const CarpoolingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final trips = ref.watch(tripProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navCarpool)),
      body:
          trips.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noTripsAvailable,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return TripCard(
                    trip: trip,
                    onRequestSeat: () {
                      ref.read(tripProvider.notifier).requestSeat(trip.tripId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.seatRequested)),
                      );
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
