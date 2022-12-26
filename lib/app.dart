import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/app/app_bloc.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';

import 'components/navigation/bottom_navigation.dart';
import 'features/login/presentation/login_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticaionState>(
        builder: (BuildContext context, authState) {
      if (authState.isAuthenticated) {
        return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return Scaffold(
            body: state.selectedPage,
            bottomNavigationBar: BottomNavigation(
              initialIndex: state.selectedIndex,
              onTap: (index) =>
                  context.read<AppBloc>().add(NavigateByIndex(index)),
            ),
          );
        });
      }

      return const LoginView();
    });
  }
}
