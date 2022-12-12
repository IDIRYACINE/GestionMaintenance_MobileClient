import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordState {
  RecordState(this.records);
  static int pendingItemsRecordIndex = 0;
  final Map<int,Record> records;

  factory RecordState.initialState() {
    Record pendingItems = Record(id: pendingItemsRecordIndex, name: 'Pending items');

    return RecordState({pendingItemsRecordIndex : pendingItems});
  }
}

enum LocationStatus { pending, done, error }
