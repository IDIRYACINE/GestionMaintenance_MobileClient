import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:gestion_maintenance_mobile/components/scanner/types.dart'
    as app;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class MlkitScanner implements app.BarcodeScanner {
  late BarcodeScanner barcodeScanner;

  MlkitScanner() {
    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    barcodeScanner = BarcodeScanner(formats: formats);
  }

  @override
  Future<List<String>> scan(CameraImage image) async {
    InputImage processImage = cameraImageToInputImage(image, 0);

    return barcodeScanner.processImage(processImage).then((barcodesList) => 
      _barcodesToString(barcodesList)
    );
  }

  InputImage cameraImageToInputImage(
      CameraImage cameraImage, int sensorOreintation) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize = Size(
      cameraImage.width.toDouble(),
      cameraImage.height.toDouble(),
    );

    const InputImageRotation imageRotation = InputImageRotation.rotation0deg;

    const InputImageFormat inputImageFormat = InputImageFormat.nv21;

    final planeData = cameraImage.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  }

  List<String> _barcodesToString(List<Barcode> barcodes){
    List<String> barcodesString = [];
    for (Barcode barcode in barcodes) {
      barcodesString.add(barcode.rawValue!);
    }
    return barcodesString;
  }
}
