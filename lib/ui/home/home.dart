import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisations.of(context)!.title),
      ),
      body: const Center(child: Text("state")),
    );
  }
}
