
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/data/departement.dart';

abstract class Database{
  Future<bool> open({required String username ,required String password});
  Future<void> close();

  Future<void> insertBarcode({required Barcode barcode,required Departement departement});
  Future<void> insertRecord({required Record record});
  Future<List<Map<String,Object?>>> loadRecord();

  
}