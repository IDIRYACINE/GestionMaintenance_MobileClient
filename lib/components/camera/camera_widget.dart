import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/camera/camera_controller.dart';
import 'package:gestion_maintenance_mobile/components/widgets/custom_rows.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'types.dart';

class CameraView extends StatelessWidget {
  const CameraView(
      {super.key,
      required this.onInitialise,
      this.resolution = ResolutionPreset.medium,
      required this.scanWidget,
      required this.flashWidget});

  final OnInitialise onInitialise;
  final ResolutionPreset resolution;
  final Widget scanWidget;
  final Widget flashWidget;

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
            flashWidget: flashWidget,
            scanWidget: scanWidget,
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
              return Center(
                  child: Text(Localisations.of(context)!.noCameraDetected));
            }

            CameraDescription backCamera = snapshot.data!.first;

            CameraController cameraController = CameraController(
                backCamera, resolution,
                imageFormatGroup: ImageFormatGroup.nv21);
            return _buildCameraPreview(cameraController, backCamera);
          } else {
            return Center(
                child: Text(Localisations.of(context)!.noCameraDetected));
          }
        });
  }
}

class _CameraPreview extends StatefulWidget {
  final CameraDescription camera;
  final CameraController cameraController;
  final Widget flashWidget;
  final Widget scanWidget;

  const _CameraPreview({
    required this.cameraController,
    required this.flashWidget,
    required this.scanWidget,
    required this.camera,
  });

  @override
  State<_CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<_CameraPreview> {
  bool isFlashOn = false;

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
              child: widget.flashWidget,
            ),
            widget.scanWidget,
          ],
        ),
      )
    ]);
  }
}

class CameraResolutionSelector extends StatefulWidget {
  const CameraResolutionSelector({
    super.key,
    required this.resolutions,
    required this.confirmLabel,
    this.maxHeight = 400,
    this.maxWidth = 300,
    required this.initialResolution,
  });

  final List<ResolutionPreset> resolutions;
  final ResolutionPreset initialResolution;
  final String confirmLabel;
  final double maxHeight;
  final double maxWidth;

  @override
  State<CameraResolutionSelector> createState() =>
      _CameraResolutionSelectorState();
}

class _CameraResolutionSelectorState extends State<CameraResolutionSelector> {
  ResolutionPreset? currentResolution;

  void onResolutionSelected(ResolutionPreset? newResolution) {
    if ((newResolution != null) && (newResolution != currentResolution)) {
      setState(() {
        currentResolution = newResolution;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentResolution ??= widget.initialResolution;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
        maxWidth: widget.maxWidth,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: ((context, index) => RadioRow<ResolutionPreset>(
                  title: widget.resolutions[index].name,
                  rowValue: widget.resolutions[index],
                  groupValue: currentResolution!,
                  onSelected: onResolutionSelected)),
              itemCount: widget.resolutions.length,
            ),
          ),
          MaterialButton(
            child: Text(widget.confirmLabel),
            onPressed: () {
              Navigator.pop(context, currentResolution);
            },
          )
        ],
      ),
    );
  }
}

// ignore: unused_element
class _ActiveSquareOverlay extends StatelessWidget {
  final Size cameraPreviewSize;
  final double squareSize = 300;

  const _ActiveSquareOverlay({
    required this.cameraPreviewSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cameraPreviewSize.width,
      height: cameraPreviewSize.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: (cameraPreviewSize.width - squareSize) / 2,
            top: (cameraPreviewSize.height - squareSize) / 2,
            child: Container(
              width: squareSize,
              height: squareSize,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
