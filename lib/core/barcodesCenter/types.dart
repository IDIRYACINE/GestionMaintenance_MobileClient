abstract class BarcodeManger {
  
  Future<void> emitBarcode(String barcode);

  void subscribeToBarcodeStream(BarcodeSubscriber subscriber);
  void unSubscribeToBarcodeStream(BarcodeSubscriber subscriber);

  void addExtension(BarcodeCenterExtension bExtension);
  void removeExtension(BarcodeCenterExtension bExtension);
}

abstract class BarcodeSubscriber {
  void onBarcode(String barcode);
}

abstract class BarcodeCenterExtension {
    void onBarcode(String barcode);
}

class UnassaignedExtension implements BarcodeCenterExtension {
  UnassaignedExtension._();
  static UnassaignedExtension? _instance;


  factory UnassaignedExtension.instance() {
    _instance ??= UnassaignedExtension._();
    return _instance!;
  }

  @override
  void onBarcode(String barcode) {}
}

enum RegisteredExtensions{
  soundPlayer,
  toaster,
  vibrator
}
