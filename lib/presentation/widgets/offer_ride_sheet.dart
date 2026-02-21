import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/trip_model.dart';
import '../../domain/providers/trip_provider.dart';

class OfferRideSheet extends ConsumerStatefulWidget {
  const OfferRideSheet({super.key});

  @override
  ConsumerState<OfferRideSheet> createState() => _OfferRideSheetState();
}

class _OfferRideSheetState extends ConsumerState<OfferRideSheet> {
  final _formKey = GlobalKey<FormState>();
  final _driverController = TextEditingController();
  String? _selectedDestination;
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _totalSeats = 3;

  @override
  void dispose() {
    _driverController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDestination != null) {
      final now = DateTime.now();
      final departure = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final trip = TripModel(
        tripId: const Uuid().v4(),
        driverName: _driverController.text.trim(),
        destination: _selectedDestination!,
        departureTime: departure,
        totalSeats: _totalSeats,
        availableSeats: _totalSeats - 1,
      );

      ref.read(tripProvider.notifier).addTrip(trip);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.offerRide,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _driverController,
              decoration: InputDecoration(
                labelText: l10n.driverName,
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.driverName;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedDestination,
              decoration: InputDecoration(
                labelText: l10n.selectDestination,
                prefixIcon: const Icon(Icons.location_on),
              ),
              items:
                  MockData.destinations.map((dest) {
                    return DropdownMenuItem(value: dest, child: Text(dest));
                  }).toList(),
              onChanged: (value) {
                setState(() => _selectedDestination = value);
              },
              validator: (value) {
                if (value == null) return l10n.selectDestination;
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: Text(l10n.departureTime),
              trailing: Text(
                _selectedTime.format(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (time != null) {
                  setState(() => _selectedTime = time);
                }
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.event_seat, color: Colors.grey),
                const SizedBox(width: 12),
                Text(l10n.totalSeats),
                const Spacer(),
                IconButton(
                  onPressed:
                      _totalSeats > 1
                          ? () => setState(() => _totalSeats--)
                          : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '$_totalSeats',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed:
                      _totalSeats < 7
                          ? () => setState(() => _totalSeats++)
                          : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submit,
              child: Text(l10n.publish),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
