import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/trip_model.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final VoidCallback? onRequestSeat;

  const TripCard({super.key, required this.trip, this.onRequestSeat});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeFormat = DateFormat('HH:mm');

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryBlue,
          child: Text(
            trip.driverName[0],
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          trip.destination,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trip.driverName),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(timeFormat.format(trip.departureTime)),
                const SizedBox(width: 12),
                Icon(
                  Icons.event_seat,
                  size: 14,
                  color:
                      trip.availableSeats > 0
                          ? AppTheme.accentGreen
                          : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.seatsAvailable(trip.availableSeats),
                  style: TextStyle(
                    color:
                        trip.availableSeats > 0
                            ? AppTheme.accentGreen
                            : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing:
            trip.availableSeats > 0
                ? FilledButton(
                  onPressed: onRequestSeat,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Text(
                    l10n.requestSeat,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
                : null,
        isThreeLine: true,
      ),
    );
  }
}
