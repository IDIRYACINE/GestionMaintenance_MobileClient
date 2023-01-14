import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'package:sqflite_common/sqlite_api.dart' as sql;

class InsertWaitingBarcodeTask extends ServiceTask<WorkResult> {
  InsertWaitingBarcodeTask(this._db, this._repository);

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

class LoadBarcodeWaitingQueueTask extends ServiceTask<WorkResult> {
  LoadBarcodeWaitingQueueTask(this._db, this._repository);

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

class DeleteBarcodeFromWaitingQueueTask extends ServiceTask<WorkResult> {
  DeleteBarcodeFromWaitingQueueTask(this._db);

  final sql.Database _db;

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    return _db
        .delete(barcodesQueueTable,
            where: "${BarcodeQueueTableColumns.barcode.name} = ?",
            whereArgs: [barcode.barcode])
        .then((value) =>
            WorkResult(workId: -1, status: OperationStatus.success, data: null))
        .onError((error, stackTrace) => WorkResult(
            workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class UpdateBarcodeStateTask extends ServiceTask<WorkResult> {
  UpdateBarcodeStateTask(this._db);

  final sql.Database _db;

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    return _db
        .update(barcodesQueueTable,
            {BarcodeQueueTableColumns.status.name: barcode.state.index},
            where: "${BarcodeQueueTableColumns.barcode.name} = ?",
            whereArgs: [barcode.barcode])
        .then((value) =>
            WorkResult(workId: -1, status: OperationStatus.success, data: null))
        .onError((error, stackTrace) => WorkResult(
            workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class InsertScannedBarcodeTask extends ServiceTask<WorkResult> {
  InsertScannedBarcodeTask(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    Record record = requestData[RequestDataKeys.record];
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try {
      await _db.insert(scannedBarcodesTable,
          _repository.mapToScannedBarcodeMap(record, barcode));

      await _db.update(designationsTable,
          {DesignationTableColumns.productsCount.name: record.count},
          where: "${DesignationTableColumns.departmentId.name} = ?",
          whereArgs: [record.id]);

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: null);
    } catch (e) {
      return WorkResult(workId: -1, status: OperationStatus.error, data: e);
    }
  }
}

class InsertDesignationTask extends ServiceTask<WorkResult> {
  InsertDesignationTask(this._db, this._repository);

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

class LoadRecordsTask extends ServiceTask<WorkResult> {
  LoadRecordsTask(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  @override
  Future<WorkResult> execute(requestData) async {
    try {
      final resultSet = await _db.query(designationsTable);

      Map<int, Record> designations = _repository.mapToRecordMap(resultSet);
      return _loadDesignationsBarcodes(designations);
    } catch (e) {

      return WorkResult(workId: -1, status: OperationStatus.error, data: {});
    }
  }

  Future<WorkResult> _loadDesignationsBarcodes(
      Map<int, Record> designations) async {
    ResultSet resultSet = await _db.query(scannedBarcodesTable);

    _repository.mapToBarcodeListAndAssignToDesignation(resultSet, designations);

    return WorkResult(
        workId: -1, status: OperationStatus.success, data: designations);
  }
}
