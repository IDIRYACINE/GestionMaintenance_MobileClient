import 'package:gestion_maintenance_mobile/blocs/settings/types.dart';
import 'package:camera/camera.dart';

class SettingsState {
  final ToggleSettingsItem _playSoundSetting;
  final ToggleSettingsItem _vibrateOnScanSetting;
  final ToggleSettingsItem _continousScanSetting;
  final ComboSettingsItem<ResolutionPreset> _cameraResolutionSetting;

  SettingsState(this._playSoundSetting, this._vibrateOnScanSetting,
      this._continousScanSetting, this._cameraResolutionSetting);

  ToggleSettingsItem get playSoundSetting => _playSoundSetting;
  ToggleSettingsItem get vibrateOnScanSetting => _vibrateOnScanSetting;
  ToggleSettingsItem get continousScanSetting => _continousScanSetting;
    ComboSettingsItem<ResolutionPreset> get cameraResolutionSetting => _cameraResolutionSetting;


  SettingsState copyWith(
      {ToggleSettingsItem? playSoundSetting,
      ToggleSettingsItem? vibrateOnScanSetting,
      ToggleSettingsItem? continousScanSetting,
      ComboSettingsItem<ResolutionPreset>? cameraResolutionSetting}) {
    return SettingsState(
        playSoundSetting ?? _playSoundSetting,
        vibrateOnScanSetting ?? _vibrateOnScanSetting,
        continousScanSetting ?? _continousScanSetting,
        cameraResolutionSetting ?? _cameraResolutionSetting);
  }

  factory SettingsState.initialState() => SettingsState(
      PlaySoundSetting(enabled: true),
      VibrateOnScanSetting(enabled: false),
      ContinousScanSetting(enabled: false),
      CameraResolutionSetting(ResolutionPreset.medium));

}


class PlaySoundSetting implements ToggleSettingsItem{
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


class VibrateOnScanSetting implements ToggleSettingsItem{
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

class ContinousScanSetting implements ToggleSettingsItem{
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

class CameraResolutionSetting implements ComboSettingsItem<ResolutionPreset>{

  CameraResolutionSetting(this._value);

  final ResolutionPreset _value;

  @override
  String? getDescription() {
    return _value.name;
  }

  @override
  SettingsTypes get id => SettingsTypes.cameraResolution;

  @override
  String get name => SettingsTypes.cameraResolution.name;

  @override
  ResolutionPreset get value => _value;

  static List<ResolutionPreset> get allValues => ResolutionPreset.values;

}