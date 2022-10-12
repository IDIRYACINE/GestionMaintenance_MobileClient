import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/stores/app_state.dart';
import 'package:gestion_maintenance_mobile/stores/settings/scan_actions.dart';
import 'package:gestion_maintenance_mobile/stores/settings/scan_reducers.dart';
import 'package:gestion_maintenance_mobile/ui/home/home.dart';
import 'package:redux/redux.dart';

import 'ui/themes/constants.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  void registerReducers() {
    ReducerRegister.instance().registerReducer((index) {
      ToggleVibrationAction().setIndex(index);
      return ToggleVibrationReducer();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final Store<AppState> store = Store<AppState>(
      (state, action) {
        return appStateReducer(state, action);
      },
      initialState: AppState.initialState(),
    );

    registerReducers();

    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        title: appName,
        localizationsDelegates: Localisations.localizationsDelegates,
        supportedLocales: Localisations.supportedLocales,
        home: HomePage(),
      ),
    );
  }
}
