import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/core/navigation/router.dart';
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
        return ValueListenableBuilder<int>(
            valueListenable: AppRouter.bottomBarIndex,
            builder: (context, index, child) {
              return Scaffold(
                body: AppRouter.selectedPage,
                bottomNavigationBar: BottomNavigation(
                    initialIndex: AppRouter.bottomBarIndex.value,
                    onTap: AppRouter.setBottomBarIndex),
              );
            });
      }

      return const LoginView();
    });
  }
}
