import 'package:camera/camera.dart';

import 'types.dart';

Future<List<CameraDescription>> getCameras() async {
  return await availableCameras();
}


class CameraScannerController implements ScannerController {
  final CameraController cameraController;

  CameraScannerController(this.cameraController);

  @override
  Future<void> startImageStream(OnImage onImage) async {
    cameraController.startImageStream(onImage);
  }

  @override
  Future<void> stopImageStream() async {
    await cameraController.stopImageStream();
  }

}