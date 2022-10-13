import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_controller.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

typedef CamerasList = List<CameraDescription>;

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  Widget buildCameraPreview(
      CameraController cameraController, CameraDescription cameraDescription) {
    return FutureBuilder<void>(
      future: cameraController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _CameraPreview(
            cameraController: cameraController,
            camera: cameraDescription,
            onPicture: (String? path) {},
          );
        } else {
          return Center(
            child: MaterialButton(
              onPressed: () {},
              child: Text(Localisations.of(context)!.requestCameraAccess),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CamerasList>(
        future: getCameras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Text(Localisations.of(context)!.noCameraDetected);
            }

            CameraDescription backCamera = snapshot.data!.first;

            CameraController cameraController = CameraController(
              backCamera,
              ResolutionPreset.medium,
            );
            return buildCameraPreview(cameraController,backCamera);
          } else {
            return Text(Localisations.of(context)!.noCameraDetected);
          }
        });
  }
}

typedef OnPicture = void Function(String? path);

class _CameraPreview extends StatefulWidget {
  final CameraDescription camera;
  final CameraController cameraController;
  final Widget? flashToggle;
  final Widget? scanPicture;
  final OnPicture onPicture;

  const _CameraPreview(
      {required this.cameraController,
      this.flashToggle,
      this.scanPicture,
      required this.onPicture,
      required this.camera});

  @override
  State<_CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<_CameraPreview> {
  @override
  Widget build(BuildContext context) {
    return widget.cameraController.buildPreview();
  }
}
