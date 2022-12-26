import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/features/themes/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? username;

  String? password;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      LoginEvent event = LoginEvent(username: username!, password: password!);
      BlocProvider.of<AuthBloc>(context).add(event);
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return Localisations.of(context)!.errorEmptyField;
    }
    username = value;
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Localisations.of(context)!.errorEmptyField;
    }
    password = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.5,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(loginLogoAsset)),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: Localisations.of(context)!.username,
                    ),
                    validator: validateUsername,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: Localisations.of(context)!.password,
                    ),
                    obscureText: true,
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => login(),
                    child: Text(Localisations.of(context)!.login),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
