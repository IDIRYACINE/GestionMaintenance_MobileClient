import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<AuthBloc, AuthenticaionState>(builder: (ctx, state) {
        if (!state.isAuthenticated) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorOccured) {
          return Center(
              child: Text(Localisations.of(context)!.errorAuthFailed));
        }

        Navigator.of(context).pop();
        return const SizedBox();
      }),
    );
  }
}
