import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/data/departement.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/Types/constants.dart';
import '../Types/interfaces.dart' as app;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase implements app.Database {
  late Database _db;

  @override
  Future<void> close() async {
    _db.close();
  }

  @override
  Future<void> insertBarcode(
      {required Barcode barcode, required Departement departement}) async {
    String query = ''' 
      INSERT INTO $recordsTable(
        ${RecordsTableColumns.barcode.name},
        ${RecordsTableColumns.date.name},
        ${RecordsTableColumns.status.name},
        ${RecordsTableColumns.name.name},
        ${RecordsTableColumns.departmentId.name},
        ${RecordsTableColumns.departmentName.name}

      ) VALUES(
        ${barcode.barcode},
        ${barcode.scannedDate},
        ${barcode.state},
        ${barcode.name},
        ${departement.departmentId},
        ${departement.departmentName}
      )
    ''';

    _db.execute(query);
  }

  @override
  Future<void> insertRecord({required Record record}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, Object?>>> loadRecord() async {
    String query = ''' SELECT * FROM $recordsTable''';

    return _db.query(query);
  }

  @override
  Future<bool> open(
      {required String username, required String password}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      String dbPath = "${directory.path}/$databaseName";

      _db = await openDatabase(
        dbPath,
        version: databaseVersion,
        onCreate: _onCreate,
      );
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<void> _onCreate(Database db, int version) async {
    String query = ''' 
      Create Table IF NOT EXISTS $recordsTable(
        ${RecordsTableColumns.id.name} ${RecordsTableColumns.id.type},
        ${RecordsTableColumns.barcode.name} ${RecordsTableColumns.barcode.type},
        ${RecordsTableColumns.status.name} ${RecordsTableColumns.status.type},
        ${RecordsTableColumns.date.name} ${RecordsTableColumns.date.type},
        ${RecordsTableColumns.sessionId.name} ${RecordsTableColumns.sessionId.type},
        ${RecordsTableColumns.name.name} ${RecordsTableColumns.name.type},
        ${RecordsTableColumns.departmentId.name} ${RecordsTableColumns.departmentId.type},
        ${RecordsTableColumns.departmentName.name} ${RecordsTableColumns.departmentName.type},
      )
    ''';

    await db.execute(query);
  }
}
