
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
    late Record record;

    if (records.containsKey(event.locationId) == false) {
      record = Record(
          barcodes: {},
          id: event.locationId,
          name: event.locationName,
          count: 1,
          state: LocationStatus.done);
      
      records[event.locationId] = record;
    } else {
      record = records[event.locationId]!;
    }

    Record pendingItemsRecod = records[RecordState.pendingItemsRecordIndex]!;
    pendingItemsRecod.barcodes.remove(event.barcode.barcode);
    pendingItemsRecod.count = pendingItemsRecod.count - 1;

    record.barcodes[event.barcode.barcode] = event.barcode;
    record.count = pendingItemsRecod.count + 1;


    emit(RecordState(records));
  }
}
