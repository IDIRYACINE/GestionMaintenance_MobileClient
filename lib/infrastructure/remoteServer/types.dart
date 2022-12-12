
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/data/products.dart';

typedef AppJson = Map<String, dynamic>;

abstract class Database{
  Future<bool> open({required String username ,required String password});
  Future<void> close();

  Future<void> insertBarcode({required Barcode barcode});
  Future<void> insertRecord({required Record record});
  Future<Record> loadRecord();
}

abstract class RemoteServer{
  Future<bool> authenticate({required String username ,required  String password});

  Future<void> sendBarcode({required Barcode barcode});
  Future<void> sendRecord({required Record record});
}

abstract class Repository{
  Future<StockProduct> stockProductFromJson({required AppJson json});
  Future<AppJson> stockProductToJson({required AppJson json});

  Future<InventoryProduct> inventoryProductFromJson({required AppJson json});
  Future<AppJson> inventoryProductToJson({required AppJson json});

  Future<Record> recordFromJson({required AppJson json});
  Future<AppJson> recordToJson({required AppJson json});

}