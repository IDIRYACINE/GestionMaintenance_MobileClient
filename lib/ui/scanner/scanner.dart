import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftoast/ftoast.dart';
import 'package:gestion_maintenance_mobile/blocs/app/app_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/app/app_event.dart';
import 'package:gestion_maintenance_mobile/blocs/app/app_state.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_widget.dart';
import 'package:gestion_maintenance_mobile/components/camera/types.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/core/scanner/scanner.dart';
import 'package:gestion_maintenance_mobile/infrastructure/types.dart';
import 'package:gestion_maintenance_mobile/ui/themes/themes.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToasterExtension.instance().setBuildContext(context);

    Scanner scanner = Scanner(toggleScanState: (bool isScanning) {
      context.read<AppBloc>().add(ToggleScanState(isScanning));
    });

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
        onInitialise: initialiseScanner,
        flashWidget: const _FlashWidget(),
        scanWidget: ScanButton(
          onScan: onScan,
        ),
      ),
    ));
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
  const ScanButton({super.key, required this.onScan});

  final Callback<bool> onScan;

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(buildWhen: (oldState, newState) {
      return oldState.isScanning != newState.isScanning;
    }, builder: (context, state) {
      bool isScanning = state.isScanning;

      Icon icon = isScanning
          ? const Icon(Icons.stop)
          : const Icon(Icons.qr_code_scanner);

      return MaterialButton(
        color: AppColors.transparentWhite,
        onPressed: () {
          widget.onScan(isScanning);
        },
        child: icon,
      );
    });
  }
}
