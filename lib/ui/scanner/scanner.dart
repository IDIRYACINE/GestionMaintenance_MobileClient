import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_widget.dart';
import 'package:gestion_maintenance_mobile/components/camera/types.dart';
import 'package:gestion_maintenance_mobile/core/scanner/scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Scanner scanner = Scanner();

    void onScan(bool isScanning) {
      scanner.toggleScan(isScanning);
    }

    void initialiseScanner(ScannerController scanController) {
      scanner.setScannerController(scanController);
    }

    return Scaffold(
        body: BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        scanner.setScanMode(state.continousScanSetting.enabled);
      },
      child: CameraView(
        onScanImage: onScan,
        onInitialise: initialiseScanner,
      ),
    ));
  }
}
