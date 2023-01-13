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
        return 'INTEGER PRIMARY KEY AUTOINCREMENT';
      case ScannedBarcodeTableColumns.barcode:
        return 'INTEGER NOT NULL';
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

enum DesignationsTableColumns {
  departmentId,
  departmentName,
  productsCount,
  sessionId,
}

extension DesignationsTableAttributes on DesignationsTableColumns {
  String get name {
    switch (this) {
      case DesignationsTableColumns.departmentId:
        return 'department_id';
      case DesignationsTableColumns.departmentName:
        return 'department_name';
      case DesignationsTableColumns.productsCount:
        return 'productsCount';
      case DesignationsTableColumns.sessionId:
        return 'session_id';
    }
  }

  String get type {
    switch (this) {
      case DesignationsTableColumns.departmentId:
        return 'INTEGER NOT NULL';
      case DesignationsTableColumns.departmentName:
        return 'TEXT NOT NULL';
      case DesignationsTableColumns.sessionId:
        return 'INTEGER NOT NULL';
      case DesignationsTableColumns.productsCount:
        return 'INTEGER NOT NULL';
    }
  }
}

String barcodesQueueTable = 'barcodes_queue';

enum BarcodesQueueTableColumns {
  barcode,
  status,
  date
}

extension BarcodesQueueTableAttributes on BarcodesQueueTableColumns {
  String get name {
    switch (this) {
      case BarcodesQueueTableColumns.barcode:
        return 'barcode';
      case BarcodesQueueTableColumns.status:
        return 'status';
      case BarcodesQueueTableColumns.date:
        return 'date';
    }
  }

  String get type {
    switch (this) {
      case BarcodesQueueTableColumns.barcode:
        return 'INTEGER NOT NULL';
      case BarcodesQueueTableColumns.status:
        return 'INTEGER NOT NULL';
      case BarcodesQueueTableColumns.date:
        return 'DATE NOT NULL';
    }
  }
}