import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/app.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/core/navigation/navigator.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/settings/settings_bloc.dart';
import 'features/themes/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final directory = await getApplicationDocumentsDirectory();
  ServicesCenter.instance(storagePath: directory.path);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SettingsBloc()),
    BlocProvider(create: (_) => RecordsBloc()),
    BlocProvider(create: (_) => AuthBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> initApp(BuildContext appContext) async {
    BarcodeCenter.instance(
        recordsBloc: appContext.read<RecordsBloc>(),
        authBloc: appContext.read<AuthBloc>());
    BarcodeCenter.initExtensions(SettingsState.initialState());
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      localizationsDelegates: Localisations.localizationsDelegates,
      supportedLocales: Localisations.supportedLocales,
      navigatorKey: AppNavigator.key,
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
