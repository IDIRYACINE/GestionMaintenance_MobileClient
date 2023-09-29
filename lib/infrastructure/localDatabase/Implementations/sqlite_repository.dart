import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';

class DatabaseRepository {
  static const _barcodeStates = BarcodeStates.values;
  static const _recordStates = LocationStatus.values;

  List<Barcode> mapToBarcodeList(ResultSet maps) {
    List<Barcode> barcodes = [];

    for (Map<String, dynamic> map in maps) {
      barcodes.add(mapToBarcode(map));
    }

    return barcodes;
  }

  Map<String, dynamic> mapToBarcodeMap(Barcode barcode) => {
        BarcodeQueueTableColumns.barcode.name: barcode.barcode,
        BarcodeQueueTableColumns.date.name: barcode.scannedDate.toString(),
        BarcodeQueueTableColumns.status.name: barcode.state.index
      };

  List<Record> mapToRecordList(ResultSet value) {
    List<Record> records = [];

    for (Map<String, Object?> map in value) {
      int recordState = map[ScannedBarcodeTableColumns.status.name] as int;

      records.add(Record(
          id: map[DesignationTableColumns.departmentId.name] as String,
          name: map[DesignationTableColumns.departmentName.name] as String?,
          count: map[DesignationTableColumns.productsCount.name] as int,
          state: _recordStates[recordState],
          barcodes: {}));
    }

    return records;
  }

  Barcode mapToBarcode(Map<String, dynamic> element) {
    int barcodeState = element[BarcodeQueueTableColumns.status.name];
    DateTime date = DateTime.parse(element[BarcodeQueueTableColumns.date.name]);

    return Barcode(
        barcode: element[BarcodeQueueTableColumns.barcode.name],
        scannedDate: date,
        state: _barcodeStates[barcodeState]);
  }

  Barcode mapToScannedBarcode(Map<String, dynamic> element) {
    int barcodeState = element[ScannedBarcodeTableColumns.status.name];
    DateTime date = DateTime.parse(element[ScannedBarcodeTableColumns.date.name]);

    return Barcode(
        barcode: element[ScannedBarcodeTableColumns.barcode.name],
        scannedDate: date,
        name: element[ScannedBarcodeTableColumns.name.name],
        state: _barcodeStates[barcodeState]);
  }

  Map<String, Object?> mapToDesignationMap(Record record) {
    Map<String, Object?> designationMap = {
      DesignationTableColumns.departmentName.name: record.name,
      DesignationTableColumns.departmentId.name: record.id,
      DesignationTableColumns.productsCount.name: record.count,
    };
    return designationMap;
  }

  Map<String, Record> mapToRecordMap(ResultSet value) {
    Map<String, Record> records = {};

    for (Map<String, Object?> map in value) {
      String recordId = map[DesignationTableColumns.departmentId.name] as String;

      records[recordId] = Record(
          id: recordId,
          name: map[DesignationTableColumns.departmentName.name] as String?,
          count: map[DesignationTableColumns.productsCount.name] as int,
          state: _recordStates[0],
          barcodes: {});
    }

    return records;
  }

  void mapToBarcodeListAndAssignToDesignation(
      ResultSet resultSet, Map<String, Record> designations) {
    for (var element in resultSet) {
      String departmentId =
          element[ScannedBarcodeTableColumns.departmentId.name] as String;
      Barcode barcode = mapToScannedBarcode(element);
      designations[departmentId]?.barcodes[barcode.barcode] = barcode;
    }
  }

  Map<String, Object?> mapToScannedBarcodeMap(Record record, Barcode barcode) {
    Map<String, Object?> map = {
      ScannedBarcodeTableColumns.barcode.name: barcode.barcode,
      ScannedBarcodeTableColumns.departmentId.name: record.id,
      ScannedBarcodeTableColumns.name.name : barcode.name,
      ScannedBarcodeTableColumns.status.name : barcode.state.index,
      ScannedBarcodeTableColumns.date.name : barcode.scannedDate.toString()
    };

    return map;
  }
}
