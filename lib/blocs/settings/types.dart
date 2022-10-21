
enum SettingsTypes{
  vibrateOnScan,
  playSoundOnScan,
  continousScan,
  cameraResolution
}

abstract class SettingsBloc{
  Stream get soundSettings;
  Stream get vibrationSettings;
  Stream get scanSettings;

  void dispose();

  void togglePlaySound();
  void toggleVibrateOnScan();
  void toggleContinousScan();

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