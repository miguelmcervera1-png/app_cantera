import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'La 21'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Portal - La 21'**
  String get loginTitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Perico ID'**
  String get loginButton;

  /// No description provided for @loginHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your Perico ID'**
  String get loginHint;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCarpool.
  ///
  /// In en, this message translates to:
  /// **'Carpooling'**
  String get navCarpool;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @nextMatch.
  ///
  /// In en, this message translates to:
  /// **'Next Match'**
  String get nextMatch;

  /// No description provided for @seatsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} seats free'**
  String seatsAvailable(int count);

  /// No description provided for @offerRide.
  ///
  /// In en, this message translates to:
  /// **'Offer a ride'**
  String get offerRide;

  /// No description provided for @requestSeat.
  ///
  /// In en, this message translates to:
  /// **'Request seat'**
  String get requestSeat;

  /// No description provided for @seatRequested.
  ///
  /// In en, this message translates to:
  /// **'Seat requested successfully!'**
  String get seatRequested;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @departureTime.
  ///
  /// In en, this message translates to:
  /// **'Departure time'**
  String get departureTime;

  /// No description provided for @totalSeats.
  ///
  /// In en, this message translates to:
  /// **'Total seats'**
  String get totalSeats;

  /// No description provided for @driverName.
  ///
  /// In en, this message translates to:
  /// **'Driver name'**
  String get driverName;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @vs.
  ///
  /// In en, this message translates to:
  /// **'vs'**
  String get vs;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @regulations.
  ///
  /// In en, this message translates to:
  /// **'Regulations'**
  String get regulations;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Data Collection: User name and contact data (Email) provided by the club\'s central authentication system.\n\nLocation Usage: The app does not track in real-time, it only stores static text meeting points.\n\nCarpooling Liability: \"La 21\" acts only as a facilitator. The club is not responsible for incidents during private trips.'**
  String get privacyBody;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsTitle;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'By using this application you agree to the terms and conditions of the La 21 family portal. The carpooling service is a coordination tool between families and does not imply any contractual transport relationship.'**
  String get termsBody;

  /// No description provided for @noTripsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No trips available'**
  String get noTripsAvailable;

  /// No description provided for @ridePublished.
  ///
  /// In en, this message translates to:
  /// **'Ride published successfully!'**
  String get ridePublished;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeBack(String name);

  /// No description provided for @selectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select destination'**
  String get selectDestination;

  /// No description provided for @navComms.
  ///
  /// In en, this message translates to:
  /// **'Communications'**
  String get navComms;

  /// No description provided for @tabNotices.
  ///
  /// In en, this message translates to:
  /// **'Official Notices'**
  String get tabNotices;

  /// No description provided for @tabSchedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule'**
  String get tabSchedule;

  /// No description provided for @confirmRead.
  ///
  /// In en, this message translates to:
  /// **'I have read this'**
  String get confirmRead;

  /// No description provided for @trainingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Training Cancelled'**
  String get trainingCancelled;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get filterAll;

  /// No description provided for @filterMyTeam.
  ///
  /// In en, this message translates to:
  /// **'My Team'**
  String get filterMyTeam;

  /// No description provided for @filterAdmin.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get filterAdmin;

  /// No description provided for @urgentNotice.
  ///
  /// In en, this message translates to:
  /// **'Urgent Notice'**
  String get urgentNotice;

  /// No description provided for @noNotices.
  ///
  /// In en, this message translates to:
  /// **'No notices available'**
  String get noNotices;

  /// No description provided for @noticeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Read confirmed'**
  String get noticeConfirmed;

  /// No description provided for @sendNotice.
  ///
  /// In en, this message translates to:
  /// **'Send Notice'**
  String get sendNotice;

  /// No description provided for @adminPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel (Mock)'**
  String get adminPanel;

  /// No description provided for @noticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Notice title'**
  String get noticeTitle;

  /// No description provided for @noticeBody.
  ///
  /// In en, this message translates to:
  /// **'Notice body'**
  String get noticeBody;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @selectTeam.
  ///
  /// In en, this message translates to:
  /// **'Select team'**
  String get selectTeam;

  /// No description provided for @categoryUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get categoryUrgent;

  /// No description provided for @categoryInfo.
  ///
  /// In en, this message translates to:
  /// **'Informative'**
  String get categoryInfo;

  /// No description provided for @categoryCallup.
  ///
  /// In en, this message translates to:
  /// **'Call-up'**
  String get categoryCallup;

  /// No description provided for @requiresConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Requires read confirmation'**
  String get requiresConfirmation;

  /// No description provided for @noticeSent.
  ///
  /// In en, this message translates to:
  /// **'Notice sent successfully!'**
  String get noticeSent;

  /// No description provided for @allTeams.
  ///
  /// In en, this message translates to:
  /// **'All Teams'**
  String get allTeams;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @noSchedule.
  ///
  /// In en, this message translates to:
  /// **'No scheduled events'**
  String get noSchedule;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get match;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
