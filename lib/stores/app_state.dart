
import 'package:gestion_maintenance_mobile/stores/authentication/authentication.dart';
import 'package:gestion_maintenance_mobile/stores/records/records.dart';
import 'package:gestion_maintenance_mobile/stores/settings/settings_store.dart';

import 'types.dart';

class AppState{
  SettingsState settingsState;
  RecordsState recordsState;
  AuthenticaionState authenticationState;
  
  AppState({
    required this.settingsState ,
    required this.recordsState ,
    required this.authenticationState ,
  });

  factory AppState.initialState() => AppState(
    settingsState: SettingsState.initialState(),
    recordsState: RecordsState.initialState(),
    authenticationState: AuthenticaionState.initialState(),
  );

  AppState copyWith({
    SettingsState? settingsState,
    AuthenticaionState? authenticationState,
    RecordsState? recordsState,
  }) {
    return AppState(
      settingsState: settingsState ?? this.settingsState,
       authenticationState: authenticationState ?? this.authenticationState,
        recordsState: recordsState?? this.recordsState,
    );
  }

}

AppState appStateReducer(AppState currentState , StoreAction action){
  return ReducerRegister.instance().reduce(currentState, action);
}


class ReducerRegister implements ReducersCombiner{
  static ReducerRegister? _instance;
  List<ReducerExecutable> reducers = [];

  factory ReducerRegister.instance(){
    _instance ??= ReducerRegister._();
    return _instance!;
  }

  ReducerRegister._();

  @override
  void registerReducer(ReducerBuilder reducerBuilder) {
    int index = reducers.length ;
    ReducerExecutable reducer = reducerBuilder(index);
    reducers.add(reducer);
  }
  
  @override
  AppState reduce<S>(S currentState, StoreAction action) {
    return reducers[action.index].reduce(currentState, action);
  }
  
}