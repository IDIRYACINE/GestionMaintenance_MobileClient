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
  }
}
