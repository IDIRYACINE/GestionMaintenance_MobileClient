import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordState {
  RecordState(this.records);
  static String pendingItemsRecordIndex = '';
  final Map<String,Record> records;

  factory RecordState.initialState() {
    Record pendingItems = Record(barcodes: {},id: pendingItemsRecordIndex, name: 'Pending items');

    return RecordState({pendingItemsRecordIndex : pendingItems});
  }
}

enum LocationStatus { pending, done, error }
