import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/local_database_request.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

class RecordsBloc extends Bloc<RecordEvent, RecordState> {
  RecordsBloc() : super(RecordState.initialState()) {
    on<AddRecord>((_addRecord));
    on<LoadRecords>((_loadRecords));
    on<LoadWaitingBarcodes>(_loadWaitingRecord);
    on<AddBarcode>((_addBarcode));
    on<UpdateBarcode>((_updateBarcode));
    on<BarcodeAlreadyScanned>((_barcodeAlreadyScanned));
    on<BatchSubmitScannedItems>((_batchSubmitScannedItems));
    on<UpdateBarcodeBatch>((_updateBarcodeBatch));
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
    Map<int, Record> records = Map.from(state.records);
    records.addAll(event.records);

    emit(RecordState(records));
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

  Future<void> _updateBarcodeBatch(
      UpdateBarcodeBatch event, Emitter<RecordState> emit) async {
    Map<int, Record> records = Map.from(state.records);
    Record pendingItemsRecord = records[RecordState.pendingItemsRecordIndex]!;

    late Record record;

    event.batch.forEach((locationId, barcodeBatch) {
      if (records.containsKey(locationId) == false) {
        record = Record(
            barcodes: {},
            id: locationId,
            name: barcodeBatch.locationName,
            count: 1,
            state: LocationStatus.done);

        records[locationId] = record;

        _registerNewDesignation(record);
      } else {
        record = records[locationId]!;
      }

      for (Barcode barcode in barcodeBatch.barcodes) {
        pendingItemsRecord.barcodes.remove(barcode.barcode);
        pendingItemsRecord.count = pendingItemsRecord.count - 1;

        record.barcodes[barcode.barcode] = barcode;
        record.count = pendingItemsRecord.count + 1;

        _registerScannedBarcode(barcode, record);
      }
    });

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

  FutureOr<void> _loadWaitingRecord(
      LoadWaitingBarcodes event, Emitter<RecordState> emit) {
    Map<int, Record> records = Map.from(state.records);

    Record pendingItemsRecord = records[RecordState.pendingItemsRecordIndex]!;

    Map<int, Barcode> barcodes = {};
    for (Barcode element in event.barcodes) {
      barcodes[element.barcode] = element;
    }

    pendingItemsRecord.copyWith(
        barcodes: barcodes, count: event.barcodes.length);

    records[RecordState.pendingItemsRecordIndex] = pendingItemsRecord;

    emit(RecordState(records));
  }

  FutureOr<void> _barcodeAlreadyScanned(
      BarcodeAlreadyScanned event, Emitter<RecordState> emit) {
    Record pendingItemsRecord =
        state.records[RecordState.pendingItemsRecordIndex]!;
    pendingItemsRecord.barcodes.remove(event.barcode.barcode);

    Map<int, Record> updatedRecords = Map.from(state.records);
    updatedRecords[RecordState.pendingItemsRecordIndex] = pendingItemsRecord;

    LocalDatabaseRequestBuilder.deleteBarcodeFromWaitingQueue(
        barcode: event.barcode);

    emit(RecordState(updatedRecords));
  }

  Future<void> _batchSubmitScannedItems(
      BatchSubmitScannedItems event, Emitter<RecordState> emit) async {
    final pendingItems = state.records[RecordState.pendingItemsRecordIndex]!;

    if (pendingItems.count > 0) {
      BarcodeCenter.instance().submitBarcodeBatch(pendingItems);
    }
  }
}
