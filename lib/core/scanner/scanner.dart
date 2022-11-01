import 'package:camera/camera.dart';
import 'package:gestion_maintenance_mobile/components/camera/types.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/core/scanner/types.dart';
import 'package:gestion_maintenance_mobile/infrastructure/types.dart';
import 'google_analyser.dart';

class Scanner {
  Scanner({required Callback<bool> toggleScanState}) {
    _analyser = MlkitScanner();
    _toggleScanState = toggleScanState;
  }

  late Callback<bool> _toggleScanState;
  late BarcodeAnalyser _analyser;
  late ScannerController _controller;

  bool _isContinousScan = false;
  bool _isScanning = false;

  void toggleScan(bool isScanning) {
    if (isScanning) {
      _controller.stopImageStream();
      _toggleScanState(false);
      _isScanning = false;
      return;
    }
    _controller.startImageStream(_onCameraImage);
    _toggleScanState(true);
    _isScanning = true;
  }

  void setScanMode(bool isContinousScan) {
    if (isContinousScan == _isContinousScan) return;

    _isContinousScan = isContinousScan;
    if (_isScanning) _controller.stopImageStream();
    _isScanning = false;
    _toggleScanState(false);
  }

  void setScannerController(ScannerController controller) {
    _controller = controller;
  }

  void _onCameraImage(CameraImage image) {
    _analyser.scan(image).then((barcodes) {
      String? barcode = barcodes.first;
      if (_isValidBarcode(barcode)) {
        BarcodeCenter.instance().emitBarcode(barcode);
        if (!_isContinousScan && _isScanning) {
          _controller.stopImageStream();
          _toggleScanState(false);
          _isScanning = false;
        }
      }
    });
  }

  bool _isValidBarcode(String barcode) {
    return int.tryParse(barcode) != null;
  }
}
