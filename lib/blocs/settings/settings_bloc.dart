import 'settings_event.dart';
import 'settings_state.dart';
import 'package:bloc/bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent,SettingsState>{

  SettingsBloc() : super(SettingsState.initialState()){
    on<ToggleContinousScan>((_onToggleScan) );
    on<ToggleVibrateOnScan>((_onToggleVibrateOnScan) );
    on<TogglePlaySound>((_onTogglePlaySound) );
  }

  Future<void> _onToggleScan(ToggleContinousScan event,Emitter<SettingsState> emitter) async{
    ContinousScanSetting newSetting = ContinousScanSetting(enabled: !state.continousScanSetting.enabled);
    emitter(state.copyWith(continousScanSetting: newSetting));
  }

  Future<void> _onToggleVibrateOnScan(ToggleVibrateOnScan event,Emitter<SettingsState> emitter) async{
    VibrateOnScanSetting newSetting = VibrateOnScanSetting(enabled: !state.vibrateOnScanSetting.enabled);
    emitter(state.copyWith(vibrateOnScanSetting: newSetting));
  }

  Future<void> _onTogglePlaySound(TogglePlaySound event,Emitter<SettingsState> emitter) async{
    PlaySoundSetting newSetting = PlaySoundSetting(enabled: !state.playSoundSetting.enabled);
    emitter(state.copyWith(playSoundSetting: newSetting));
  }

  
}

