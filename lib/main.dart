import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/app.dart';
import 'package:gestion_maintenance_mobile/blocs/app/bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'features/themes/constants.dart';

void main() {
  ServicesCenter.instance();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SettingsBloc()),
    BlocProvider(create: (_) => AppBloc()),
    BlocProvider(create: (_) => RecordsBloc()),
    BlocProvider(create: (_) => AuthBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> initApp(BuildContext appContext) async {
    BarcodeCenter.instance(recordsBloc: appContext.read<RecordsBloc>());
    BarcodeCenter.initExtensions(SettingsState.initialState());
    await Future.delayed(const Duration(seconds: 5));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      localizationsDelegates: Localisations.localizationsDelegates,
      supportedLocales: Localisations.supportedLocales,
      home: FutureBuilder<void>(
          future: initApp(context),
          builder: (builderContext, snpashot) {
            if (snpashot.connectionState == ConnectionState.done) {
              return const App();
            }
            return const SplashScreen();
          }),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
