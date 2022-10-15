
import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_view.dart';

class ScannerPage extends StatelessWidget{
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CameraView(),
    );
  }
}