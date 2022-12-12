import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordsBloc extends Bloc<RecordEvent, RecordState> {
  RecordsBloc() : super(RecordState.initialState()) {
    on<AddRecord>((_addRecord));
    on<LoadRecords>((_loadRecords));
    on<AddBarcode>((_addBarcode));
    on<UpdateBarcode>((_updateBarcode));
  }

  Future<void> _addRecord(AddRecord event, Emitter<RecordState> emit) async {
    Map<int, Record> records = Map.from(state.records);

    if (records.containsKey(event.record.id)) {
      Record record = records[event.record.id]!;
      if (record.state == LocationStatus.done) return;
    }

    records[event.record.id] = event.record;
    emit(RecordState(records));
  }

  Future<void> _loadRecords(
      LoadRecords event, Emitter<RecordState> emit) async {
    emit(RecordState(event.records));
  }

  Future<void> _addBarcode(AddBarcode event, Emitter<RecordState> emit) async {
    Map<int, Record> records = Map.from(state.records);

    Map<int, Barcode> newBarcodes =
        Map.from(records[RecordState.pendingItemsRecordIndex]!.barcodes);
    newBarcodes[event.barcode] =
        Barcode(barcode: event.barcode, scannedDate: DateTime.now());

    Record oldRecord = records[RecordState.pendingItemsRecordIndex]!;
    records[RecordState.pendingItemsRecordIndex] =
        oldRecord.copyWith(barcodes: newBarcodes, count: newBarcodes.length);

    emit(RecordState(records));
  }

  Future<void> _updateBarcode(
      UpdateBarcode event, Emitter<RecordState> emit) async {
    Map<int, Record> records = Map.from(state.records);

    if (records.containsKey(event.locationId) == false) {
      Record record = Record(
          id: event.locationId,
          name: event.locationName,
          count: 1,
          state: LocationStatus.done);
      if (record.state == LocationStatus.done) return;
    }

    records[RecordState.pendingItemsRecordIndex]!
        .barcodes
        .remove(event.barcode.barcode);
    records[event.locationId]!.barcodes[event.barcode.barcode] = event.barcode;

    emit(RecordState(records));
  }
}
