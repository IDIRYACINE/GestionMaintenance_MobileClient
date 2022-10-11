
class Barcode {
  int barcode;
  DateTime scannedDate;
  int count;

  Barcode({required this.barcode , required this.scannedDate , this.count = 1});
}

class BarcodeGroup {
  Map<int,Barcode> barcodes;
  int count;
  String name;
  int id;

  BarcodeGroup({this.barcodes = const {},required this.id,required this.name,this.count = 1});
}

class Record {
  Map<int,BarcodeGroup> groups;

  Record({this.groups = const {}});
}