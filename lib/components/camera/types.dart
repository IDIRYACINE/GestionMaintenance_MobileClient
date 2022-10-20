
import 'package:camera/camera.dart';

abstract class ScannerController {
  Future<void> startImageStream(dynamic Function(CameraImage image) onImage);
  Future<void> stopImageStream();
}

typedef OnImage = void Function(CameraImage image);
typedef CamerasList = List<CameraDescription>;
typedef OnScanImage = void Function(bool isScanning);
typedef OnInitialise = void Function(ScannerController scannerController);