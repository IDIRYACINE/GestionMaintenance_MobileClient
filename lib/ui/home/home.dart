import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/stores/app_state.dart';
import 'package:gestion_maintenance_mobile/stores/settings/scan_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, appState) => Scaffold(
        appBar: AppBar(
          title: Text(Localisations.of(context)!.title),
        ),
        body: Center(
          child: StoreConnector<AppState, String>(
            converter: (store) {
              return store.state.settingsState.playSound.enabled.toString();
            },
            builder: (context, state) {
              return Text(state);
            },
          ),
        ),
        floatingActionButton: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(ToggleVibrationAction());
          },
          builder: (context, callback) {
            return FloatingActionButton(
              onPressed: callback,
              tooltip: 'test',
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
