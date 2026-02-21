// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'La 21';

  @override
  String get loginTitle => 'Portal de Familias - La 21';

  @override
  String get loginButton => 'Iniciar sesión con Perico ID';

  @override
  String get loginHint => 'Introduce tu Perico ID';

  @override
  String get navHome => 'Inicio';

  @override
  String get navCarpool => 'Viajes';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get nextMatch => 'Próximo Partido';

  @override
  String seatsAvailable(int count) {
    return '$count plazas libres';
  }

  @override
  String get offerRide => 'Ofrecer coche';

  @override
  String get requestSeat => 'Solicitar plaza';

  @override
  String get seatRequested => '¡Plaza solicitada con éxito!';

  @override
  String get destination => 'Destino';

  @override
  String get departureTime => 'Hora de salida';

  @override
  String get totalSeats => 'Plazas totales';

  @override
  String get driverName => 'Nombre del conductor';

  @override
  String get publish => 'Publicar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get vs => 'vs';

  @override
  String get category => 'Categoría';

  @override
  String get location => 'Ubicación';

  @override
  String get date => 'Fecha';

  @override
  String get quickAccess => 'Acceso Rápido';

  @override
  String get regulations => 'Normativa';

  @override
  String get language => 'Idioma';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm => '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get privacyTitle => 'Política de Privacidad';

  @override
  String get privacyBody =>
      'Recopilación de Datos: Nombre del usuario y datos de contacto (Email) proporcionados por el sistema de autenticación central del club.\n\nUso de Localización: La app no rastrea en tiempo real, solo almacena puntos de encuentro estáticos de texto.\n\nResponsabilidad (Carpooling): \"La 21\" actúa solo como facilitador. El club no se hace responsable de incidentes durante los trayectos privados.';

  @override
  String get termsTitle => 'Términos de Uso';

  @override
  String get termsBody =>
      'Al utilizar esta aplicación aceptas los términos y condiciones del portal de familias La 21. El servicio de carpooling es una herramienta de coordinación entre familias y no implica ninguna relación contractual de transporte.';

  @override
  String get noTripsAvailable => 'No hay viajes disponibles';

  @override
  String get ridePublished => '¡Viaje publicado con éxito!';

  @override
  String welcomeBack(String name) {
    return '¡Bienvenido, $name!';
  }

  @override
  String get selectDestination => 'Seleccionar destino';

  @override
  String get navComms => 'Comunicaciones';

  @override
  String get tabNotices => 'Avisos Oficiales';

  @override
  String get tabSchedule => 'Mi Horario';

  @override
  String get confirmRead => 'He leído esto';

  @override
  String get trainingCancelled => 'Entrenamiento Suspendido';

  @override
  String get filterAll => 'General';

  @override
  String get filterMyTeam => 'Mi Equipo';

  @override
  String get filterAdmin => 'Pagos';

  @override
  String get urgentNotice => 'Aviso Urgente';

  @override
  String get noNotices => 'No hay avisos disponibles';

  @override
  String get noticeConfirmed => 'Lectura confirmada';

  @override
  String get sendNotice => 'Enviar Aviso';

  @override
  String get adminPanel => 'Panel Admin (Mock)';

  @override
  String get noticeTitle => 'Título del aviso';

  @override
  String get noticeBody => 'Contenido del aviso';

  @override
  String get selectCategory => 'Seleccionar categoría';

  @override
  String get selectTeam => 'Seleccionar equipo';

  @override
  String get categoryUrgent => 'Urgente';

  @override
  String get categoryInfo => 'Informativo';

  @override
  String get categoryCallup => 'Convocatoria';

  @override
  String get requiresConfirmation => 'Requiere confirmación de lectura';

  @override
  String get noticeSent => '¡Aviso enviado con éxito!';

  @override
  String get allTeams => 'Todos los Equipos';

  @override
  String get schedule => 'Horario';

  @override
  String get noSchedule => 'No hay eventos programados';

  @override
  String get training => 'Entrenamiento';

  @override
  String get match => 'Partido';
}
