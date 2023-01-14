import 'dart:async';

import 'package:gestion_maintenance_mobile/infrastructure/forwarder.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/Implementations/commands.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/Implementations/sqlite_repository.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/Types/constants.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/Types/tasks.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../Types/interfaces.dart' as app;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteDatabase extends ServiceHandler implements app.Database {

  late Database _db;

  final List<ServiceTask> _services = [];
  final DatabaseRepository _repository = DatabaseRepository();
  final String _storagePath;

  SqliteDatabase(this._storagePath) ;

  @override
  Future<void> close() async {
    _db.close();
  }

  @override
  Future<bool> open(
      {required String username, required String password}) async {
    try {

      String dbPath = "$_storagePath/$databaseName";
      _db = await databaseFactoryFfi.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ),
      );


    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future handleMessage(RequestData message) {
    return _services[message.task.index].execute(message.data).then((value) {
      WorkResult result = value as WorkResult;

      result.workId = message.messageId;

      return result;
    });
  }

  Future<void> _registerTasks() async{

    _services[LocalDatabaseTasks.loadScannedBarcodes.index] =
        LoadRecordsTask(_db, _repository);

    _services[LocalDatabaseTasks.insertBarcodeIntoScanned.index] =
        InsertScannedBarcodeTask(_db, _repository);

    _services[LocalDatabaseTasks.deleteBarcodeFromWaitingQueue.index] =
        DeleteBarcodeFromWaitingQueueTask(_db);

    _services[LocalDatabaseTasks.insertDesignation.index] =
        InsertDesignationTask(_db, _repository);

    _services[LocalDatabaseTasks.loadBarcodeWaitingQueue.index] =
        LoadBarcodeWaitingQueueTask(_db, _repository);

    _services[LocalDatabaseTasks.updateWaitingBarcodeState.index] =
        UpdateBarcodeStateTask(_db);

    _services[LocalDatabaseTasks.insertBarcodeIntoWaitingQueue.index] =
        InsertWaitingBarcodeTask(_db, _repository);
  }

  void _initialiseTaskSlots() {
    EmptyTask emptyTask = EmptyTask();
    for (int i = 0; i < LocalDatabaseTasks.values.length; i++) {
      _services.add(emptyTask);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    String query = ''' 
      Create Table IF NOT EXISTS $scannedBarcodesTable(
        ${ScannedBarcodeTableColumns.id.name} ${ScannedBarcodeTableColumns.id.type},
        ${ScannedBarcodeTableColumns.barcode.name} ${ScannedBarcodeTableColumns.barcode.type},
        ${ScannedBarcodeTableColumns.status.name} ${ScannedBarcodeTableColumns.status.type},
        ${ScannedBarcodeTableColumns.date.name} ${ScannedBarcodeTableColumns.date.type},
        ${ScannedBarcodeTableColumns.sessionId.name} ${ScannedBarcodeTableColumns.sessionId.type},
        ${ScannedBarcodeTableColumns.name.name} ${ScannedBarcodeTableColumns.name.type},
        ${ScannedBarcodeTableColumns.departmentId.name} ${ScannedBarcodeTableColumns.departmentId.type}
      )
    ''';

    await db.execute(query);

    query = ''' Create Table IF NOT EXISTS $designationsTable
    (
      ${DesignationTableColumns.productsCount.name} ${DesignationTableColumns.productsCount.type},
      ${DesignationTableColumns.departmentName.name} ${DesignationTableColumns.departmentName.type},
      ${DesignationTableColumns.departmentId.name} ${DesignationTableColumns.departmentId.type}
    )
    ''';

    await db.execute(query);

    query = ''' Create Table IF NOT EXISTS $barcodesQueueTable
    (
      ${BarcodeQueueTableColumns.barcode.name} ${BarcodeQueueTableColumns.barcode.type},
      ${BarcodeQueueTableColumns.status.name} ${BarcodeQueueTableColumns.status.type},
      ${BarcodeQueueTableColumns.date.name} ${BarcodeQueueTableColumns.date.type}
    )
    ''';

    await db.execute(query);


  }
  
  @override
  Future<void> init() async{
     _initialiseTaskSlots();

    await open(username: "", password: "");
      _registerTasks();
  }
}
