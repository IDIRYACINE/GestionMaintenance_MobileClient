import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_event.dart';
import 'package:gestion_maintenance_mobile/blocs/display/display_state.dart';
import 'package:gestion_maintenance_mobile/components/navigation/bottom_navigation.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      localizationsDelegates: Localisations.localizationsDelegates,
      supportedLocales: Localisations.supportedLocales,
      home: BlocBuilder<DisplayBloc, DisplayState>(builder: (context, state) {
        return Scaffold(
          body: state.selectedPage,
          bottomNavigationBar: BottomNavigation(
            initialIndex: state.selectedIndex,
            onTap: (index) =>
                context.read<DisplayBloc>().add(NavigateByIndex(index)),
          ),
        );
      }),
    );
  }
}
