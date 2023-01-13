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
        BarcodesQueueTableColumns.barcode.name: barcode.barcode,
        BarcodesQueueTableColumns.date.name: barcode.scannedDate,
        BarcodesQueueTableColumns.status.name: barcode.state.index
      };

  List<Record> mapToRecordList(ResultSet value) {
    List<Record> records = [];

    for (Map<String, Object?> map in value) {
      int recordState = map[ScannedBarcodeTableColumns.status.name] as int;

      records.add(Record(
          id: map[DesignationsTableColumns.departmentId.name] as int,
          name: map[DesignationsTableColumns.departmentName.name] as String?,
          count: map[DesignationsTableColumns.productsCount.name] as int,
          state: _recordStates[recordState],
          barcodes: {}));
    }

    return records;
  }

  Barcode mapToBarcode(Map<String, dynamic> element) {
    int barcodeState = element[BarcodesQueueTableColumns.status.name];

    return Barcode(
        barcode: element[BarcodesQueueTableColumns.barcode.name],
        scannedDate: element[BarcodesQueueTableColumns.date.name],
        state: _barcodeStates[barcodeState]);
  }

  Map<String, Object?> mapToDesignationMap(Record record) {
    Map<String, Object?> designationMap = {
      DesignationsTableColumns.departmentName.name: record.name,
      DesignationsTableColumns.departmentId.name: record.count,
      DesignationsTableColumns.productsCount.name: record.barcodes.length,
    };
    return designationMap;
  }

  Map<int, Record> mapToRecordMap(ResultSet value) {
    Map<int, Record> records = {};

    for (Map<String, Object?> map in value) {
      int recordState = map[ScannedBarcodeTableColumns.status.name] as int;
      int recordId = map[DesignationsTableColumns.departmentId.name] as int;

      records[recordId] = Record(
          id: recordId,
          name: map[DesignationsTableColumns.departmentName.name] as String?,
          count: map[DesignationsTableColumns.productsCount.name] as int,
          state: _recordStates[recordState],
          barcodes: {});
    }

    return records;
  }

  void mapToBarcodeListAndAssignToDesignation(
      ResultSet resultSet, Map<int, Record> designations) {
    for (var element in resultSet) {
      int departmentId =
          element[DesignationsTableColumns.departmentId.name] as int;
      Barcode barcode = mapToBarcode(element);

      designations[departmentId]?.barcodes[barcode.barcode] = barcode;
    }
  }

  Map<String, Object?> mapToScannedBarcode(Record record, Barcode barcode) {
    Map<String, Object?> map = {
      ScannedBarcodeTableColumns.barcode.name: barcode.barcode,
      ScannedBarcodeTableColumns.departmentId.name: record.id,
      ScannedBarcodeTableColumns.name.name : barcode.name,
      ScannedBarcodeTableColumns.status.name : barcode.state,
      ScannedBarcodeTableColumns.date.name : barcode.scannedDate
    };

    return map;
  }
}
