enum BarcodeStates { pending, loaded, error }

class Barcode {
  int barcode;
  DateTime scannedDate;
  int count;
  BarcodeStates state;
  String? name;

  Barcode(
      {required this.barcode,
      required this.scannedDate,
      this.count = 1,
      this.state = BarcodeStates.pending,
      this.name});
}

class Record {
  Map<int, Barcode> barcodes;
  int count;
  String? name;
  int id;

  Record(
      {this.barcodes = const {}, required this.id, this.name, this.count = 1});
}
