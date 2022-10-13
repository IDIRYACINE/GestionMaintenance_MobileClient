

import 'package:camera/camera.dart';

abstract class BarcodeScanner{
  Future<List<String>> scan(CameraImage image);
  

}