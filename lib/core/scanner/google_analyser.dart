import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:gestion_maintenance_mobile/core/scanner/types.dart' as app;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class MlkitScanner implements app.BarcodeAnalyser {
  late BarcodeScanner barcodeScanner;

  MlkitScanner() {
    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    barcodeScanner = BarcodeScanner(formats: formats);
  }

  @override
  Future<List<String>> scan(CameraImage image) async {
    InputImage processImage = cameraImageToInputImage(image, 0);

    return barcodeScanner
        .processImage(processImage)
        .then((barcodesList) => _barcodesToString(barcodesList));
  }

  InputImage cameraImageToInputImage(CameraImage image, int sensorOrientation) {
    InputImageRotation? rotation;

    var rotationCompensation = sensorOrientation;

    rotationCompensation =
        (sensorOrientation - rotationCompensation + 360) % 360;
    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation!, // used only in Android
        format: format!, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  List<String> _barcodesToString(List<Barcode> barcodes) {
    List<String> barcodesString = [];
    for (Barcode barcode in barcodes) {
      barcodesString.add(barcode.rawValue!);
    }
    return barcodesString;
  }
}
