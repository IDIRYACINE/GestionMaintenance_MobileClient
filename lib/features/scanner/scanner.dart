import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_bloc.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_widget.dart';
import 'package:gestion_maintenance_mobile/components/camera/types.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/core/scanner/scanner.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'package:gestion_maintenance_mobile/features/themes/themes.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Scanner scanner = Scanner();

  void onScan(bool isScanning) {
    scanner.toggleScan(isScanning);
  }

  void initialiseScanner(ScannerController scanController) {
    scanner.setScannerController(scanController);
  }

  @override
  Widget build(BuildContext context) {
    ToasterExtension.instance().setBuildContext(context);

    scanner.setScanMode(BlocProvider.of<SettingsBloc>(context)
        .state
        .continousScanSetting
        .enabled);

    return Scaffold(
      body: CameraView(
        onInitialise: initialiseScanner,
        flashWidget: const _FlashWidget(),
        scanWidget: ScanButton(
          onScan: onScan,
          registerScanCallback: scanner.scanButtonStatusSetter,
        ),
      ),
    );
  }
}

class _FlashWidget extends StatelessWidget {
  const _FlashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparentWhite,
      child: const Icon(Icons.flash_on, size: 40),
    );
  }
}

class ScanButton extends StatefulWidget {
  const ScanButton(
      {super.key, required this.onScan, required this.registerScanCallback});

  final Callback<bool> onScan;
  final void Function(void Function(bool isScanning) callback)
      registerScanCallback;

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  bool isScanning = false;

  @override
  void initState() {
    widget.registerScanCallback((bool isScanning) {
      setState(() {
        this.isScanning = isScanning;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Icon icon =
        isScanning ? const Icon(Icons.stop) : const Icon(Icons.qr_code_scanner);

    return MaterialButton(
      color: AppColors.transparentWhite,
      onPressed: () {
        widget.onScan(isScanning);
      },
      child: icon,
    );
  }
}
