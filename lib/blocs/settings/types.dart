
enum SettingsTypes{
  vibrateOnScan,
  playSoundOnScan,
  continousScan,
  cameraResolution
}

abstract class ToggleSettingsItem{
  SettingsTypes get id;

  bool get enabled;

  String? getDescription();

  String get name;

}


abstract class ComboSettingsItem<T>{
  SettingsTypes get id;

  T get value;

  String? getDescription();

  String get name;

}