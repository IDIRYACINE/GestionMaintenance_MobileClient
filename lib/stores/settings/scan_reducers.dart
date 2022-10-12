
import 'package:gestion_maintenance_mobile/stores/app_state.dart';
import 'package:gestion_maintenance_mobile/stores/settings/settings_store.dart';
import 'package:gestion_maintenance_mobile/stores/types.dart';

class ToggleVibrationReducer implements ReducerExecutable<AppState>{

  @override
  AppState reduce(AppState appState, StoreAction action){
    SettingsState state = appState.settingsState;

    SettingsState newState = state.copyWith(
      playSound: PlaySoundSetting(enabled: !state.playSound.enabled),
    );

    return appState.copyWith(settingsState: newState);

  }

}