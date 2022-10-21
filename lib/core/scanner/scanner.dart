import 'package:camera/camera.dart';
import 'package:gestion_maintenance_mobile/components/camera/types.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/core/scanner/types.dart';
import 'google_analyser.dart';
import 'dart:developer' as dev;

class Scanner {
  Scanner() {
    _analyser = MlkitScanner();
  }

  late BarcodeAnalyser _analyser;
  late ScannerController _controller;

  bool _isContinousScan = false;

  void toggleScan(isScanning) {
    if (isScanning) {
      _controller.stopImageStream();
      return;
    }
    _controller.startImageStream(_onCameraImage);
  }

  void setScanMode(bool isContinousScan) {
    if (isContinousScan == _isContinousScan) return;
    _isContinousScan = isContinousScan;
    _controller.stopImageStream();
  }

  void setScannerController(ScannerController controller) {
    _controller = controller;
  }

  void _onCameraImage(CameraImage image) {
    _analyser.scan(image).then((barcodes) {
      String? barcode = barcodes.first;
      dev.log("Barcode: $barcode", name: "idir.app");
      if (_isValidBarcode(barcode)) {
        BarcodeCenter.instance().emitBarcode(barcode);
        if (!_isContinousScan) {
          _controller.stopImageStream();
        }
      }
    });
  }

  bool _isValidBarcode(String barcode) {
    return int.tryParse(barcode) != null;
  }
}
