import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';

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

  Barcode copyWith(
      {int? barcode,
      DateTime? scannedDate,
      int? count,
      BarcodeStates? state,
      String? name}) {
    return Barcode(
        barcode: barcode ?? this.barcode,
        scannedDate: scannedDate ?? this.scannedDate,
        count: count ?? this.count,
        state: state ?? this.state,
        name: name ?? this.name);
  }
}

class Record {
  Map<int, Barcode> barcodes;
  int count;
  String? name;
  int id;
  LocationStatus state;

  Record(
      {this.barcodes = const {},
      required this.id,
      this.name,
      this.count = 0,
      this.state = LocationStatus.pending});

  Record copyWith({Map<int, Barcode>? barcodes, String? name, int? count, LocationStatus? state}) {
    return Record(
        barcodes: barcodes ?? this.barcodes,
        id: id,
        name: name ?? this.name,
        count: count ?? this.count,
        state: state ?? this.state
        );
  }
}
