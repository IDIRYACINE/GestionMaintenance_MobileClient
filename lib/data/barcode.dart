class Barcode {
  int barcode;
  DateTime scannedDate;
  int count;

  Barcode({required this.barcode, required this.scannedDate, this.count = 1});
}

class Record {
  Map<int, Barcode> barcodes;
  int count;
  String name;
  int id;

  Record(
      {this.barcodes = const {},
      required this.id,
      required this.name,
      this.count = 1});
}

