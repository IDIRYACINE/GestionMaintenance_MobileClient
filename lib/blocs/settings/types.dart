
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

abstract class SettingsBloc{
  Stream get soundSettings;
  Stream get vibrationSettings;
  Stream get scanSettings;

  void dispose();

  void togglePlaySound();
  void toggleVibrateOnScan();
  void toggleContinousScan();

}
