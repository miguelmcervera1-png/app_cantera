import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/trip_model.dart';

class TripNotifier extends StateNotifier<List<TripModel>> {
  TripNotifier() : super(MockData.trips);

  void addTrip(TripModel trip) {
    state = [...state, trip];
  }

  void requestSeat(String tripId) {
    state = [
      for (final trip in state)
        if (trip.tripId == tripId && trip.availableSeats > 0)
          trip.copyWith(availableSeats: trip.availableSeats - 1)
        else
          trip,
    ];
  }
}

final tripProvider = StateNotifierProvider<TripNotifier, List<TripModel>>(
  (ref) => TripNotifier(),
);
