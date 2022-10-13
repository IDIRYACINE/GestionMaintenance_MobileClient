import 'package:camera/camera.dart';

Future<List<CameraDescription>> getCameras() async {
  return await availableCameras();
}

typedef OnPicture = void Function(CameraImage image);

void startImageStream(CameraController cameraController,OnPicture onPicture) {
  cameraController.startImageStream(onPicture);
}

void stopImageStream(CameraController cameraController) {}
