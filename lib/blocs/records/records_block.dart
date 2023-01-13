import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/local_database_request.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

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

    Barcode barcode =
        Barcode(barcode: event.barcode, scannedDate: DateTime.now());
    _addBarcodeToWaitingQueue(barcode);

    newBarcodes[event.barcode] = barcode;

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

      _registerNewDesignation(record);
    } else {
      record = records[event.locationId]!;
    }

    Record pendingItemsRecod = records[RecordState.pendingItemsRecordIndex]!;
    pendingItemsRecod.barcodes.remove(event.barcode.barcode);
    pendingItemsRecod.count = pendingItemsRecod.count - 1;

    record.barcodes[event.barcode.barcode] = event.barcode;
    record.count = pendingItemsRecod.count + 1;

    _registerScannedBarcode(event.barcode, record);

    emit(RecordState(records));
  }

  void _addBarcodeToWaitingQueue(Barcode barcode) {
    WorkRequest<void> addBarcodeToQueue =
        LocalDatabaseRequestBuilder.insertBarcodeIntoWaitingQueue(
            barcode: barcode);

    ServicesCenter.instance().emitWorkRequest(addBarcodeToQueue);
  }

  void _registerNewDesignation(Record record) {
    WorkRequest<void> registerDesignation =
        LocalDatabaseRequestBuilder.insertDesignation(record: record);

    ServicesCenter.instance().emitWorkRequest(registerDesignation);
  }

  void _registerScannedBarcode(Barcode barcode, Record record) {
    final servicesCenter = ServicesCenter.instance();

    WorkRequest<void> removeBarcodeFromQueue =
        LocalDatabaseRequestBuilder.deleteBarcodeFromWaitingQueue(
            barcode: barcode);

    servicesCenter.emitWorkRequest(removeBarcodeFromQueue);

    // this will be sent through an isolate port , which passes by value for all fields ! not by ref
    Record tempRecord = record.copyWith(barcodes: {barcode.barcode: barcode});

    WorkRequest<void> registerScannedBarcode =
        LocalDatabaseRequestBuilder.insertBarcodeIntoScanned(
            barcode: barcode, record: tempRecord);

    servicesCenter.emitWorkRequest(registerScannedBarcode);
  }
}
