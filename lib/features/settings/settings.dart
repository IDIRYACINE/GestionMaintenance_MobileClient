import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_event.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_widget.dart';
import 'package:gestion_maintenance_mobile/components/widgets/custom_rows.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/features/themes/constants.dart';
import 'dart:developer' as dev;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void toggleContinousScan(SettingsBloc bloc) {
    bloc.add(ToggleContinousScan());
  }

  void togglePlaySound(SettingsBloc bloc) {
    bloc.add(TogglePlaySound());
  }

  void toggleVibrateOnScan(SettingsBloc bloc) {
    bloc.add(ToggleVibrateOnScan());
  }

  Future<void> setCameraResolution(
      BuildContext context, SettingsBloc bloc) async {
    ResolutionPreset? newRes = await showDialog<ResolutionPreset>(
      context: context,
      builder: (bContext) => AlertDialog(
        content: CameraResolutionSelector(
          resolutions: CameraResolutionSetting.allValues,
          confirmLabel: Localisations.of(context)!.confirm,
          initialResolution: bloc.state.cameraResolutionSetting.value,
        ),
      ),
    );
    dev.log(newRes!.name, name: "app.idir");
    bloc.add(SetCameraResolution(newRes));
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBlock =
        BlocProvider.of<SettingsBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(Localisations.of(context)!.settings),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SettingsRow(
                title: Localisations.of(context)!.playSoundOnScan,
                isEnabled: settingsBlock.state.playSoundSetting.enabled,
                icon: const Icon(playSoundIcon),
                onTap: () {
                  togglePlaySound(settingsBlock);
                }),
            SettingsRow(
                title: Localisations.of(context)!.continuousScan,
                icon: const Icon(continousScanIcon),
                isEnabled: settingsBlock.state.continousScanSetting.enabled,
                onTap: () {
                  toggleContinousScan((settingsBlock));
                }),
            SettingsRow(
                title: Localisations.of(context)!.vibrateOnScan,
                icon: const Icon(vibrationIcon),
                isEnabled: settingsBlock.state.vibrateOnScanSetting.enabled,
                onTap: () {
                  toggleVibrateOnScan((settingsBlock));
                }),
            SettingsRow(
                title: Localisations.of(context)!.cameraResolution,
                description:
                    settingsBlock.state.cameraResolutionSetting.value.name,
                icon: const Icon(cameraIcon),
                onTap: () {
                  setCameraResolution(context, settingsBlock);
                }),
          ],
        ),
      ),
    );
  }
}
