import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordState {
  RecordState(this.records);
  static int pendingItemsRecordIndex = 0;
  final List<Record> records;

  factory RecordState.initialState() {
    Record pendingItems = Record(id: pendingItemsRecordIndex, name: 'Pending items');

    return RecordState([pendingItems]);
  }
}
