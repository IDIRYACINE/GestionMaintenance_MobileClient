import 'dart:async';
import 'types.dart';

class BarcodeCenter implements BarcodeManger{
  final List<BarcodeSubscriber> _subscribers = [];
  final List<BarcodeCenterExtension> _extensions = [];

  @override
  Future<void> emitBarcode(String barcode) async {
    for(BarcodeCenterExtension extension in _extensions){
      extension.onBarcode(barcode);
    }
  }
  
  @override
  void subscribeToBarcodeStream(BarcodeSubscriber subscriber) {
    _subscribers.add(subscriber);
  }
  
  @override
  void unSubscribeToBarcodeStream(BarcodeSubscriber subscriber) {
    _subscribers.remove(subscriber);
  }
  
  @override
  void addExtension(BarcodeCenterExtension bExtension) {
    _extensions.add(bExtension);
  }
  
  @override
  void removeExtension(BarcodeCenterExtension bExtension) {
    _extensions.remove(bExtension);
  }


}