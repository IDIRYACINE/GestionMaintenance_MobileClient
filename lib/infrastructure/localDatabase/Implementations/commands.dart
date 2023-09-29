// ignore_for_file: unused_field

import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'package:sqlite3/sqlite3.dart' as sql;

class InsertWaitingBarcodeTask extends ServiceTask<WorkResult> {
  InsertWaitingBarcodeTask(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  final query = "INSERT INTO $barcodesQueueTable "
      "(${BarcodeQueueTableColumns.barcode.name}, "
      "${BarcodeQueueTableColumns.date.name}, "
      "${BarcodeQueueTableColumns.status.name}) "
      "VALUES (?, ?, ?)";

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try{
      _db.execute(query, [barcode.barcode, barcode.scannedDate.toString(), barcode.state.index]);
      return WorkResult(workId: -1, status: OperationStatus.success, data: null);
    }
    catch(e){
      return WorkResult(workId: -1, status: OperationStatus.error, data: e.toString());
    }

  }
}

class LoadBarcodeWaitingQueueTask extends ServiceTask<WorkResult> {
  LoadBarcodeWaitingQueueTask(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  final query = "SELECT * FROM $barcodesQueueTable";

  @override
  Future<WorkResult> execute(requestData) async {

    try {
      var result = _db.select(query);
      return WorkResult(workId: -1, status: OperationStatus.success, data: _repository.mapToBarcodeList(result));
    }
    catch(e){
      return WorkResult(workId: -1, status: OperationStatus.error, data: e.toString());
    }
  }
}

class DeleteBarcodeFromWaitingQueueTask extends ServiceTask<WorkResult> {
  DeleteBarcodeFromWaitingQueueTask(this._db);

  final sql.Database _db;

  final query = "DELETE FROM $barcodesQueueTable WHERE ${BarcodeQueueTableColumns.barcode.name} = ?";

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try{
      _db.execute(query, [barcode.barcode]);
      return WorkResult(workId: -1, status: OperationStatus.success, data: null);
    }
    catch(e){
      return WorkResult(workId: -1, status: OperationStatus.error, data: e.toString());
    }

  }
}

class UpdateBarcodeStateTask extends ServiceTask<WorkResult> {
  UpdateBarcodeStateTask(this._db);

  final sql.Database _db;
  final query = "UPDATE $barcodesQueueTable "
      "SET ${BarcodeQueueTableColumns.status.name} = ? "
      "WHERE ${BarcodeQueueTableColumns.barcode.name} = ?";

  @override
  Future<WorkResult> execute(requestData) async {
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try{
      _db.execute(query, [barcode.state.index, barcode.barcode]);
      return WorkResult(workId: -1, status: OperationStatus.success, data: null);
    }
    catch(e){
      return WorkResult(workId: -1, status: OperationStatus.error, data: e.toString());
    }
  }
}

class InsertScannedBarcodeTask extends ServiceTask<WorkResult> {
  InsertScannedBarcodeTask(this._db, this._repository);

  final sql.Database _db;
  final DatabaseRepository _repository;

  final insertQuery = "INSERT INTO $scannedBarcodesTable "
      "(${ScannedBarcodeTableColumns.barcode.name}, "
      "${ScannedBarcodeTableColumns.departmentId.name}, "
      "${ScannedBarcodeTableColumns.date.name}, "
      "${ScannedBarcodeTableColumns.status.name}) "
      "VALUES (?, ?, ?, ?)";

  final updateQuery = "UPDATE $designationsTable "
      "SET ${DesignationTableColumns.productsCount.name} = ? "
      "WHERE ${DesignationTableColumns.departmentId.name} = ?";    

  @override
  Future<WorkResult> execute(requestData) async {
    Record record = requestData[RequestDataKeys.record];
    Barcode barcode = requestData[RequestDataKeys.barcode];

    try {
      _db.execute(insertQuery, [barcode.barcode, record.id, barcode.scannedDate.toString(), barcode.state.index]);
      _db.execute(updateQuery, [record.count, record.id]);

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

  final query = "INSERT INTO $designationsTable "
      "(${DesignationTableColumns.departmentId.name}, "
      "${DesignationTableColumns.departmentName.name}, "
      "${DesignationTableColumns.productsCount.name}) "
      "VALUES (?, ?, ?)";

  @override
  Future<WorkResult> execute(requestData) async {
    Record record = requestData[RequestDataKeys.record];

    try {
      _db.execute(query, [record.id, record.name, record.count]);
  
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

  final queryDesignations = "SELECT * FROM $designationsTable";
  final queryBarcodes = "SELECT * FROM $scannedBarcodesTable";

  @override
  Future<WorkResult> execute(requestData) async {
    try {
      ResultSet result = _db.select(queryDesignations);

      Map<String, Record> designations = _repository.mapToRecordMap(result);
      return _loadDesignationsBarcodes(designations);
    } catch (e) {
      return WorkResult(workId: -1, status: OperationStatus.error, data: {});
    }
  }

  Future<WorkResult> _loadDesignationsBarcodes(
      Map<String, Record> designations) async {
    ResultSet result = _db.select(queryBarcodes);

    _repository.mapToBarcodeListAndAssignToDesignation(result, designations);

    return WorkResult(
        workId: -1, status: OperationStatus.success, data: designations);
  }
}
