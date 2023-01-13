import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'package:sqflite/sqflite.dart' as sql;

class InsertWaitingBarcode extends ServiceTask<WorkResult> {
  InsertWaitingBarcode(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    return _db
        .insert(barcodesQueueTable, _repository.mapToBarcodeMap(barcode))
        .then((value) =>
            WorkResult(workId: -1, status: OperationStatus.success, data: null))
        .onError((error, stackTrace) => WorkResult(
            workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class LoadBarcodeWaitingQueue extends ServiceTask<WorkResult> {
  LoadBarcodeWaitingQueue(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    return _db
        .query(barcodesQueueTable)
        .then((value) => WorkResult(
            workId: -1,
            status: OperationStatus.success,
            data: _repository.mapToBarcodeList(value)))
        .onError((error, stackTrace) =>
            WorkResult(workId: -1, status: OperationStatus.error, data: []));
  }
}

class DeleteBarcodeFromWaitingQueue extends ServiceTask<WorkResult> {
  DeleteBarcodeFromWaitingQueue(this._db);

  final sql.Database _db;

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    return _db
        .delete(barcodesQueueTable,
            where: "${BarcodesQueueTableColumns.barcode.name} = ?",
            whereArgs: [barcode.barcode])
        .then((value) =>
            WorkResult(workId: -1, status: OperationStatus.success, data: null))
        .onError((error, stackTrace) => WorkResult(
            workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class UpdateBarcodeState extends ServiceTask<WorkResult> {
  UpdateBarcodeState(this._db);

  final sql.Database _db;

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    return _db
        .update(barcodesQueueTable,
            {BarcodesQueueTableColumns.status.name: barcode.state.index},
            where: "${BarcodesQueueTableColumns.barcode.name} = ?",
            whereArgs: [barcode.barcode])
        .then((value) =>
            WorkResult(workId: -1, status: OperationStatus.success, data: null))
        .onError((error, stackTrace) => WorkResult(
            workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class InsertScannedBarcode extends ServiceTask<WorkResult> {
  InsertScannedBarcode(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    Record record = requestData[RequestDataKeys.record];
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try {
    
      await _db.insert(scannedBarcodesTable,
          _repository.mapToScannedBarcode(record, barcode));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: null);
    } catch (e) {
      return WorkResult(workId: -1, status: OperationStatus.error, data: e);
    }
  }
}

class InsertDesignation extends ServiceTask<WorkResult> {
  InsertDesignation(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    Record record = requestData[RequestDataKeys.record];

    try {
      await _db.insert(
          designationsTable, _repository.mapToDesignationMap(record));
  

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: null);
    } catch (e) {
      return WorkResult(workId: -1, status: OperationStatus.error, data: e);
    }
  }
}


class LoadRecords extends ServiceTask<WorkResult> {
  LoadRecords(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    return _db.query(designationsTable).then((value) {
      Map<int, Record> designations = _repository.mapToRecordMap(value);
      return _loadDesignationsBarcodes(designations);
    }).onError((error, stackTrace) =>
        WorkResult(workId: -1, status: OperationStatus.error, data: []));
  }

  Future<WorkResult> _loadDesignationsBarcodes(
      Map<int, Record> designations) async {
    ResultSet resultSet = await _db.query(scannedBarcodesTable);
    _repository.mapToBarcodeListAndAssignToDesignation(resultSet, designations);

    return WorkResult(
        workId: -1, status: OperationStatus.success, data: designations);
  }
}
