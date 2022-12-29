const String databaseName = 'barcode.db';
const int databaseVersion = 1;

const String recordsTable = 'scanned_records';

enum RecordsTableColumns {
  id,
  barcode,
  status,
  date,
  sessionId,
  departmentId,
  departmentName,
  name,
}

extension RecordsTableAttributes on RecordsTableColumns {
  String get name {
    switch (this) {
      case RecordsTableColumns.id:
        return 'id';
      case RecordsTableColumns.barcode:
        return 'barcode';
      case RecordsTableColumns.status:
        return 'status';
      case RecordsTableColumns.date:
        return 'date';
      case RecordsTableColumns.sessionId:
        return 'session_id';
      case RecordsTableColumns.name:
        return 'barcode_name';
      case RecordsTableColumns.departmentId:
        return 'department_id';
      case RecordsTableColumns.departmentName:
        return 'department_name';
    }
  }

  String get type {
    switch (this) {
      case RecordsTableColumns.id:
        return 'INTEGER PRIMARY KEY AUTOINCREMENT';
      case RecordsTableColumns.barcode:
        return 'INTEGER NOT NULL';
      case RecordsTableColumns.status:
        return 'INTEGER NOT NULL';
      case RecordsTableColumns.date:
        return 'DATE NOT NULL';
      case RecordsTableColumns.sessionId:
        return 'INTEGER ';
      case RecordsTableColumns.name:
        return 'TEXT';
      case RecordsTableColumns.departmentId:
        return 'INTEGER';

      case RecordsTableColumns.departmentName:
        return 'TEXT';
    }
  }
}
