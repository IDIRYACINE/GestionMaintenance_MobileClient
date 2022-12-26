import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/core/extensions/sound_player.dart';
import 'package:gestion_maintenance_mobile/core/extensions/vibrator.dart';
import 'package:gestion_maintenance_mobile/features/themes/constants.dart';

import 'settings_event.dart';
import 'settings_state.dart';
import 'package:bloc/bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initialState()) {
    on<ToggleContinousScan>((_onToggleScan));
    on<ToggleVibrateOnScan>((_onToggleVibrateOnScan));
    on<TogglePlaySound>((_onTogglePlaySound));
  }

  Future<void> _onToggleScan(
      ToggleContinousScan event, Emitter<SettingsState> emitter) async {
    bool isEnabled = !state.continousScanSetting.enabled;
    ContinousScanSetting newSetting = ContinousScanSetting(enabled: isEnabled);
    emitter(state.copyWith(continousScanSetting: newSetting));
  }

  Future<void> _onToggleVibrateOnScan(
      ToggleVibrateOnScan event, Emitter<SettingsState> emitter) async {
    bool isEnabled = !state.vibrateOnScanSetting.enabled;

    VibrateOnScanSetting newSetting = VibrateOnScanSetting(enabled: isEnabled);
    if (isEnabled) {
      BarcodeCenter.instance().addExtension(VibratorExtension.instance());
    } else {
      BarcodeCenter.instance().removeExtension(VibratorExtension.instance());
    }
    emitter(state.copyWith(vibrateOnScanSetting: newSetting));
  }

  Future<void> _onTogglePlaySound(
      TogglePlaySound event, Emitter<SettingsState> emitter) async {
    bool isEnabled = !state.playSoundSetting.enabled;
    
    PlaySoundSetting newSetting = PlaySoundSetting(enabled: isEnabled);
    if (isEnabled) {
      SoundPlayerExtension soundPlayer = SoundPlayerExtension.instance();
      soundPlayer.setAsset(onScanBarcodeSound);
      BarcodeCenter.instance().addExtension(soundPlayer);
    } else {
      BarcodeCenter.instance().removeExtension(SoundPlayerExtension.instance());
    }

    emitter(state.copyWith(playSoundSetting: newSetting));
  }

}
