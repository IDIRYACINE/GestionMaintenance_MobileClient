import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_controller.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'types.dart';

class CameraView extends StatelessWidget {
  const CameraView(
      {super.key, required this.onScanImage, required this.onInitialise});

  final OnInitialise onInitialise;
  final OnScanImage onScanImage;

  Widget _buildCameraPreview(
      CameraController cameraController, CameraDescription cameraDescription) {
    return FutureBuilder<void>(
      future: cameraController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          onInitialise(CameraScannerController(cameraController));

          return _CameraPreview(
            cameraController: cameraController,
            camera: cameraDescription,
            onScanImage: onScanImage,
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
            return _buildCameraPreview(cameraController, backCamera);
          } else {
            return Text(Localisations.of(context)!.noCameraDetected);
          }
        });
  }
}

class _CameraPreview extends StatefulWidget {
  final CameraDescription camera;
  final CameraController cameraController;
  final Widget flashToggle;
  final Widget scanPicture;
  final Widget stopScanning;

  final OnScanImage onScanImage;

  const _CameraPreview({
    required this.cameraController,
    // ignore: unused_element
    this.flashToggle = const Icon(Icons.flash_on, size: 40),
    // ignore: unused_element
    this.scanPicture = const Icon(
      Icons.qr_code,
      size: 40,
    ),
    // ignore: unused_element
    this.stopScanning = const Icon(
      Icons.stop,
      size: 40,
    ),
    required this.camera,
    required this.onScanImage,
  });

  @override
  State<_CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<_CameraPreview> {
  bool isFlashOn = false;
  bool isScanning = false;

  void toggleFlash() {
    if (isFlashOn) {
      widget.cameraController.setFlashMode(FlashMode.off);
    } else {
      widget.cameraController.setFlashMode(FlashMode.torch);
    }

    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  void toggleScan() {
    setState(() {
      isScanning = !isScanning;
      widget.onScanImage(isScanning);
    });
  }

  @override
  Widget build(BuildContext context) {
    final camWidget = widget.cameraController.buildPreview();

    return Stack(children: [
      camWidget,
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: toggleFlash,
              child: widget.flashToggle,
            ),
            InkWell(
              onTap: toggleScan,
              child: isScanning ? widget.stopScanning : widget.scanPicture,
            ),
          ],
        ),
      )
    ]);
  }
}
