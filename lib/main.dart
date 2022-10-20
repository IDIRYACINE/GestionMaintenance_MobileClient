import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_event.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_state.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/components/navigation/bottom_navigation.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'ui/themes/constants.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SettingsBloc()),
    BlocProvider(create: (_) => DisplayBloc()),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<void> initApp(BuildContext appContext) async {
    BarcodeCenter.instance();
    BarcodeCenter.initExtensions(SettingsState.initialState(), appContext);
    await Future.delayed(const Duration(seconds: 5));
  }

  Widget buildApp() {
    return BlocBuilder<DisplayBloc, DisplayState>(builder: (context, state) {
      return Scaffold(
        body: state.selectedPage,
        bottomNavigationBar: BottomNavigation(
          initialIndex: state.selectedIndex,
          onTap: (index) =>
              context.read<DisplayBloc>().add(NavigateByIndex(index)),
        ),
      );
    });
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
              return buildApp();
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
