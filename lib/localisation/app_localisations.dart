import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localisations_en.dart';

/// Callers can lookup localized strings with an instance of Localisations
/// returned by `Localisations.of(context)`.
///
/// Applications need to include `Localisations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localisation/app_localisations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Localisations.localizationsDelegates,
///   supportedLocales: Localisations.supportedLocales,
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
/// be consistent with the languages listed in the Localisations.supportedLocales
/// property.
abstract class Localisations {
  Localisations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Localisations? of(BuildContext context) {
    return Localizations.of<Localisations>(context, Localisations);
  }

  static const LocalizationsDelegate<Localisations> delegate = _LocalisationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Embag GMAO'**
  String get title;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @playSoundOnScan.
  ///
  /// In en, this message translates to:
  /// **'Play sound on scan'**
  String get playSoundOnScan;

  /// No description provided for @playSoundOnScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Play a sound when a barcode is scanned'**
  String get playSoundOnScanDescription;

  /// No description provided for @vibrateOnScan.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on scan'**
  String get vibrateOnScan;

  /// No description provided for @vibrateOnScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Vibrate when a barcode is scanned'**
  String get vibrateOnScanDescription;

  /// No description provided for @continuousScan.
  ///
  /// In en, this message translates to:
  /// **'Continuous scan'**
  String get continuousScan;

  /// No description provided for @continuousScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan continuously without having to press the button'**
  String get continuousScanDescription;

  /// No description provided for @cameraResolution.
  ///
  /// In en, this message translates to:
  /// **'Camera resolution'**
  String get cameraResolution;

  /// No description provided for @cameraResolutionDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the camera resolution to use'**
  String get cameraResolutionDescription;

  /// No description provided for @scanButton.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanButton;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @noCameraDetected.
  ///
  /// In en, this message translates to:
  /// **'No camera detected'**
  String get noCameraDetected;

  /// No description provided for @requestCameraAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access'**
  String get requestCameraAccess;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;
}

class _LocalisationsDelegate extends LocalizationsDelegate<Localisations> {
  const _LocalisationsDelegate();

  @override
  Future<Localisations> load(Locale locale) {
    return SynchronousFuture<Localisations>(lookupLocalisations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_LocalisationsDelegate old) => false;
}

Localisations lookupLocalisations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return LocalisationsEn();
  }

  throw FlutterError(
    'Localisations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
