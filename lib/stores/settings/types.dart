
enum SettingsTypes{
  vibrateOnScan,
  playSoundOnScan,
  continousScan,
}

abstract class SettingsItem{
  SettingsTypes get id;

  bool get enabled;

  String? getDescription();

  String get name;

}