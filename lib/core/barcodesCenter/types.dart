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


