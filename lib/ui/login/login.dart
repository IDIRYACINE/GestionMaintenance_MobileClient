import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/ui/themes/constants.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  void login() {

  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey formKey = GlobalKey();

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Image.asset(loginLogoAsset),
            TextFormField(
              decoration: InputDecoration(
                labelText: Localisations.of(context)!.username,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: Localisations.of(context)!.password,
              ),
            ),
            MaterialButton(
              onPressed: login,
              child: Text(Localisations.of(context)!.login),
            ),
          ],
        ),
      ),
    );
  }
}
