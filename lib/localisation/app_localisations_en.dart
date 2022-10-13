import 'app_localisations.dart';

/// The translations for English (`en`).
class LocalisationsEn extends Localisations {
  LocalisationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Embag GMAO';

  @override
  String get settings => 'Settings';

  @override
  String get home => 'Home';

  @override
  String get language => 'Language';

  @override
  String get playSoundOnScan => 'Play sound on scan';

  @override
  String get playSoundOnScanDescription => 'Play a sound when a barcode is scanned';

  @override
  String get vibrateOnScan => 'Vibrate on scan';

  @override
  String get vibrateOnScanDescription => 'Vibrate when a barcode is scanned';

  @override
  String get continuousScan => 'Continuous scan';

  @override
  String get continuousScanDescription => 'Scan continuously without having to press the button';

  @override
  String get scanButton => 'Scan';

  @override
  String get send => 'Send';

  @override
  String get noCameraDetected => 'No camera detected';

  @override
  String get requestCameraAccess => 'Allow camera access';

  @override
  String get login => 'login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';
}
