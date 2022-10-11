
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/server/types.dart';

class SqliteDatabase implements Database{
  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> insertBarcode({required Barcode barcode}) {
    // TODO: implement insertBarcode
    throw UnimplementedError();
  }

  @override
  Future<void> insertRecord({required Record record}) {
    // TODO: implement insertRecord
    throw UnimplementedError();
  }

  @override
  Future<Record> loadRecord() {
    // TODO: implement loadRecord
    throw UnimplementedError();
  }

  @override
  Future<bool> open({required String username, required String password}) {
    // TODO: implement open
    throw UnimplementedError();
  }
}