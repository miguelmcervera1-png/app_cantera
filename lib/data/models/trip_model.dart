class TripModel {
  final String tripId;
  final String driverName;
  final String destination;
  final DateTime departureTime;
  final int totalSeats;
  final int availableSeats;
  final String status;

  const TripModel({
    required this.tripId,
    required this.driverName,
    required this.destination,
    required this.departureTime,
    required this.totalSeats,
    required this.availableSeats,
    this.status = 'active',
  });

  TripModel copyWith({
    String? tripId,
    String? driverName,
    String? destination,
    DateTime? departureTime,
    int? totalSeats,
    int? availableSeats,
    String? status,
  }) {
    return TripModel(
      tripId: tripId ?? this.tripId,
      driverName: driverName ?? this.driverName,
      destination: destination ?? this.destination,
      departureTime: departureTime ?? this.departureTime,
      totalSeats: totalSeats ?? this.totalSeats,
      availableSeats: availableSeats ?? this.availableSeats,
      status: status ?? this.status,
    );
  }
}
