
import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

abstract class Vibrator {
  Future<void> vibrate();
  static Future<bool> canVibreate(){
    return Vibrate.canVibrate;
  }
}

class VibratorExtension implements Vibrator , BarcodeCenterExtension {

  VibratorExtension._();

  static VibratorExtension? _instance;

  factory VibratorExtension.instance() {
    _instance ??= VibratorExtension._();
    return _instance!;
  }

  @override
  Future<void> vibrate() async {
    Vibrate.vibrate();
  }
  
  @override
  void onBarcode(String barcode) {
    vibrate();
  }
}