

import 'package:camera/camera.dart';

abstract class BarcodeAnalyser{
  Future<List<String>> scan(CameraImage image);
}

abstract class ScanMode{
  void onScan();
  void setIsScanning(bool isScanning);
  bool isScanning();
}

