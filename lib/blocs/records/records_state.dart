import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordState {
  RecordState(this.records);
  
  final List<Record> records;

  factory RecordState.initialState() => RecordState([]);

}
