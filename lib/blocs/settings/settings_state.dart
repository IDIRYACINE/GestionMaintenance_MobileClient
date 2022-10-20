import 'package:gestion_maintenance_mobile/blocs/settings/types.dart';

class SettingsState {
  final SettingsItem _playSoundSetting;
  final SettingsItem _vibrateOnScanSetting;
  final SettingsItem _continousScanSetting;

  SettingsState(this._playSoundSetting, this._vibrateOnScanSetting,
      this._continousScanSetting);

  SettingsItem get playSoundSetting => _playSoundSetting;
  SettingsItem get vibrateOnScanSetting => _vibrateOnScanSetting;
  SettingsItem get continousScanSetting => _continousScanSetting;

  SettingsState copyWith(
      {SettingsItem? playSoundSetting,
      SettingsItem? vibrateOnScanSetting,
      SettingsItem? continousScanSetting}) {
    return SettingsState(
        playSoundSetting ?? _playSoundSetting,
        vibrateOnScanSetting ?? _vibrateOnScanSetting,
        continousScanSetting ?? _continousScanSetting);
  }

  factory SettingsState.initialState() => SettingsState(
      PlaySoundSetting(enabled: true),
      VibrateOnScanSetting(enabled: false),
      ContinousScanSetting(enabled: false));

}


class PlaySoundSetting implements SettingsItem{
  late bool _enabled;
  
  PlaySoundSetting({enabled = true }){
    _enabled = enabled;
  }

  @override
  SettingsTypes get id => SettingsTypes.playSoundOnScan;

  @override
  bool get enabled => _enabled;
  
  @override
  String? getDescription() {
    return null;
  }
  
  @override
  String get name => SettingsTypes.playSoundOnScan.name;

}


class VibrateOnScanSetting implements SettingsItem{
  late bool _enabled;
  
  VibrateOnScanSetting({enabled = true }){
    _enabled = enabled;
  }
  
  @override
  SettingsTypes get id => SettingsTypes.vibrateOnScan;

  @override
  bool get enabled => _enabled;

  @override
  String? getDescription() {
    return null;
  }
  
  @override
  String get name => SettingsTypes.vibrateOnScan.name;

}

class ContinousScanSetting implements SettingsItem{
 late bool _enabled;
  
  ContinousScanSetting({enabled = true }){
    _enabled = enabled;
  }

  @override
  SettingsTypes get id => SettingsTypes.continousScan;

  @override
  bool get enabled => _enabled;

  @override
  String? getDescription() {
    return null;
  }
  
  @override
  String get name => SettingsTypes.continousScan.name;

}
