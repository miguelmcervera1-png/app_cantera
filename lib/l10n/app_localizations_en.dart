// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'La 21';

  @override
  String get loginTitle => 'Family Portal - La 21';

  @override
  String get loginButton => 'Sign in with Perico ID';

  @override
  String get loginHint => 'Enter your Perico ID';

  @override
  String get navHome => 'Home';

  @override
  String get navCarpool => 'Carpooling';

  @override
  String get navSettings => 'Settings';

  @override
  String get nextMatch => 'Next Match';

  @override
  String seatsAvailable(int count) {
    return '$count seats free';
  }

  @override
  String get offerRide => 'Offer a ride';

  @override
  String get requestSeat => 'Request seat';

  @override
  String get seatRequested => 'Seat requested successfully!';

  @override
  String get destination => 'Destination';

  @override
  String get departureTime => 'Departure time';

  @override
  String get totalSeats => 'Total seats';

  @override
  String get driverName => 'Driver name';

  @override
  String get publish => 'Publish';

  @override
  String get cancel => 'Cancel';

  @override
  String get vs => 'vs';

  @override
  String get category => 'Category';

  @override
  String get location => 'Location';

  @override
  String get date => 'Date';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get regulations => 'Regulations';

  @override
  String get language => 'Language';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get privacyBody =>
      'Data Collection: User name and contact data (Email) provided by the club\'s central authentication system.\n\nLocation Usage: The app does not track in real-time, it only stores static text meeting points.\n\nCarpooling Liability: \"La 21\" acts only as a facilitator. The club is not responsible for incidents during private trips.';

  @override
  String get termsTitle => 'Terms of Use';

  @override
  String get termsBody =>
      'By using this application you agree to the terms and conditions of the La 21 family portal. The carpooling service is a coordination tool between families and does not imply any contractual transport relationship.';

  @override
  String get noTripsAvailable => 'No trips available';

  @override
  String get ridePublished => 'Ride published successfully!';

  @override
  String welcomeBack(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get selectDestination => 'Select destination';

  @override
  String get navComms => 'Communications';

  @override
  String get tabNotices => 'Official Notices';

  @override
  String get tabSchedule => 'My Schedule';

  @override
  String get confirmRead => 'I have read this';

  @override
  String get trainingCancelled => 'Training Cancelled';

  @override
  String get filterAll => 'General';

  @override
  String get filterMyTeam => 'My Team';

  @override
  String get filterAdmin => 'Payments';

  @override
  String get urgentNotice => 'Urgent Notice';

  @override
  String get noNotices => 'No notices available';

  @override
  String get noticeConfirmed => 'Read confirmed';

  @override
  String get sendNotice => 'Send Notice';

  @override
  String get adminPanel => 'Admin Panel (Mock)';

  @override
  String get noticeTitle => 'Notice title';

  @override
  String get noticeBody => 'Notice body';

  @override
  String get selectCategory => 'Select category';

  @override
  String get selectTeam => 'Select team';

  @override
  String get categoryUrgent => 'Urgent';

  @override
  String get categoryInfo => 'Informative';

  @override
  String get categoryCallup => 'Call-up';

  @override
  String get requiresConfirmation => 'Requires read confirmation';

  @override
  String get noticeSent => 'Notice sent successfully!';

  @override
  String get allTeams => 'All Teams';

  @override
  String get schedule => 'Schedule';

  @override
  String get noSchedule => 'No scheduled events';

  @override
  String get training => 'Training';

  @override
  String get match => 'Match';
}
