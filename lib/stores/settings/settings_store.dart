import 'types.dart';

class SettingsState {
  SettingsItem playSound;
  SettingsItem vibrateOnScan;
  SettingsItem continousScan;
  
  SettingsState({
    required this.playSound ,
    required this.vibrateOnScan ,
    required this.continousScan ,
  });

  factory SettingsState.initialState() => SettingsState(
    playSound: PlaySoundSetting(),
    vibrateOnScan: VibrateOnScanSetting(),
    continousScan: ContinousScanSetting(),
  );

  copyWith({
    SettingsItem? playSound,
    SettingsItem? vibrateOnScan,
    SettingsItem? continousScan,
  }) {
    return SettingsState(
      playSound: playSound ?? this.playSound,
      vibrateOnScan: vibrateOnScan ?? this.vibrateOnScan,
      continousScan: continousScan ?? this.continousScan,
    );
  }
  
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