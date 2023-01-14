const String databaseName = 'barcode.db';
const int databaseVersion = 1;

const String scannedBarcodesTable = 'scanned_barcodes';

enum ScannedBarcodeTableColumns {
  id,
  barcode,
  status,
  date,
  sessionId,
  departmentId,
  name,
}

extension ScannedBarcodeTableAttributes on ScannedBarcodeTableColumns {
  String get name {
    switch (this) {
      case ScannedBarcodeTableColumns.id:
        return 'id';
      case ScannedBarcodeTableColumns.barcode:
        return 'barcode';
      case ScannedBarcodeTableColumns.status:
        return 'status';
      case ScannedBarcodeTableColumns.date:
        return 'date';
      case ScannedBarcodeTableColumns.sessionId:
        return 'session_id';
      case ScannedBarcodeTableColumns.name:
        return 'barcode_name';
      case ScannedBarcodeTableColumns.departmentId:
        return 'department_id';
    
    }
  }

  String get type {
    switch (this) {
      case ScannedBarcodeTableColumns.id:
        return 'INTEGER ';
      case ScannedBarcodeTableColumns.barcode:
        return 'INTEGER NOT NULL PRIMARY KEY';
      case ScannedBarcodeTableColumns.status:
        return 'INTEGER NOT NULL';
      case ScannedBarcodeTableColumns.date:
        return 'DATE NOT NULL';
      case ScannedBarcodeTableColumns.sessionId:
        return 'INTEGER ';
      case ScannedBarcodeTableColumns.name:
        return 'TEXT';
      case ScannedBarcodeTableColumns.departmentId:
        return 'INTEGER';
    }
  }
}


String designationsTable = 'designations';

enum DesignationTableColumns {
  departmentId,
  departmentName,
  productsCount,
  sessionId,
}

extension DesignationsTableAttributes on DesignationTableColumns {
  String get name {
    switch (this) {
      case DesignationTableColumns.departmentId:
        return 'department_id';
      case DesignationTableColumns.departmentName:
        return 'department_name';
      case DesignationTableColumns.productsCount:
        return 'productsCount';
      case DesignationTableColumns.sessionId:
        return 'session_id';
    }
  }

  String get type {
    switch (this) {
      case DesignationTableColumns.departmentId:
        return 'INTEGER NOT NULL PRIMARY KEY';
      case DesignationTableColumns.departmentName:
        return 'TEXT NOT NULL';
      case DesignationTableColumns.sessionId:
        return 'INTEGER NOT NULL';
      case DesignationTableColumns.productsCount:
        return 'INTEGER NOT NULL';
    }
  }
}

String barcodesQueueTable = 'barcodes_queue';

enum BarcodeQueueTableColumns {
  barcode,
  status,
  date
}

extension BarcodesQueueTableAttributes on BarcodeQueueTableColumns {
  String get name {
    switch (this) {
      case BarcodeQueueTableColumns.barcode:
        return 'barcode';
      case BarcodeQueueTableColumns.status:
        return 'status';
      case BarcodeQueueTableColumns.date:
        return 'date';
    }
  }

  String get type {
    switch (this) {
      case BarcodeQueueTableColumns.barcode:
        return 'INTEGER NOT NULL PRIMARY KEY';
      case BarcodeQueueTableColumns.status:
        return 'INTEGER NOT NULL';
      case BarcodeQueueTableColumns.date:
        return 'DATE NOT NULL';
    }
  }
}