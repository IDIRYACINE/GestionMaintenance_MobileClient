import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/core/navigation/navigator.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class LoginStatusDialog extends StatefulWidget {
  const LoginStatusDialog({super.key});

  @override
  State<LoginStatusDialog> createState() => _LoginStatusDialogState();
}

class _LoginStatusDialogState extends State<LoginStatusDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 100),
    child: BlocBuilder<AuthBloc, AuthenticaionState>(builder: (ctx, state) {
        if (!state.isAuthenticated && !state.errorOccured) {
          return const Center(child: CircularProgressIndicator());
        }
    
        if (state.errorOccured) {
          return Center(
              child: Text(Localisations.of(context)!.errorAuthFailed));
        }
    
        AppNavigator.pop();
        return const SizedBox();
      }),),
    );
  }
}
