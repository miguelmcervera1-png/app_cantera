import '../models/match_model.dart';
import '../models/notice_model.dart';
import '../models/trip_model.dart';

class MockData {
  static List<MatchModel> matches = [
    MatchModel(
      matchId: 'match-001',
      rival: 'Villarreal CF',
      date: DateTime(2026, 3, 1, 10, 0),
      location: 'Ciutat Esportiva',
      category: 'Alevín A',
    ),
    MatchModel(
      matchId: 'match-002',
      rival: 'Levante UD',
      date: DateTime(2026, 3, 8, 11, 30),
      location: 'Campo Municipal',
      category: 'Benjamín B',
    ),
    MatchModel(
      matchId: 'match-003',
      rival: 'Valencia CF',
      date: DateTime(2026, 3, 15, 9, 0),
      location: 'Ciutat Esportiva',
      category: 'Infantil A',
    ),
  ];

  static List<TripModel> trips = [
    TripModel(
      tripId: 'uuid-001',
      driverName: 'Juan Pérez',
      destination: 'Ciutat Esportiva',
      departureTime: DateTime(2026, 3, 1, 8, 30),
      totalSeats: 4,
      availableSeats: 2,
    ),
    TripModel(
      tripId: 'uuid-002',
      driverName: 'María García',
      destination: 'Campo Municipal',
      departureTime: DateTime(2026, 3, 1, 9, 0),
      totalSeats: 3,
      availableSeats: 1,
    ),
    TripModel(
      tripId: 'uuid-003',
      driverName: 'Carlos López',
      destination: 'Ciutat Esportiva',
      departureTime: DateTime(2026, 3, 8, 10, 0),
      totalSeats: 5,
      availableSeats: 3,
    ),
  ];

  static List<NoticeModel> notices = [
    NoticeModel(
      noticeId: 'not-880',
      category: NoticeCategory.callup,
      targetTeam: 'Alevín A',
      title: 'Convocatoria vs Villarreal CF',
      body:
          'Convocados para el partido del sábado 1 de marzo a las 10:00h en Ciutat Esportiva. Presentarse 45 minutos antes.',
      timestamp: DateTime(2026, 2, 27, 14, 0),
      requiresConfirmation: true,
    ),
    NoticeModel(
      noticeId: 'not-881',
      category: NoticeCategory.informative,
      targetTeam: 'all',
      title: 'Nuevo horario de entrenamientos',
      body:
          'A partir del 3 de marzo, los entrenamientos de todas las categorías se adelantan 30 minutos. Consulta tu nuevo horario en la sección Mi Horario.',
      timestamp: DateTime(2026, 2, 25, 10, 0),
    ),
    NoticeModel(
      noticeId: 'not-882',
      category: NoticeCategory.urgent,
      targetTeam: 'Alevín A',
      title: 'Cambio de Campo',
      body:
          'El entrenamiento de hoy se traslada al Campo 3 por mantenimiento.',
      timestamp: DateTime(2026, 2, 21, 16, 0),
      requiresConfirmation: true,
    ),
    NoticeModel(
      noticeId: 'not-883',
      category: NoticeCategory.informative,
      targetTeam: 'all',
      title: 'Pago cuota trimestral',
      body:
          'Recordatorio: el plazo para abonar la cuota del tercer trimestre finaliza el 15 de marzo.',
      timestamp: DateTime(2026, 2, 20, 9, 0),
    ),
  ];

  static const List<String> destinations = [
    'Ciutat Esportiva',
    'Campo Municipal',
    'Polideportivo Central',
    'Estadio La 21',
  ];

  static const List<String> teams = [
    'Alevín A',
    'Alevín B',
    'Benjamín A',
    'Benjamín B',
    'Infantil A',
    'Infantil B',
  ];
}
