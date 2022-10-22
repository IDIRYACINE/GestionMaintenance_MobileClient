import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordEvent{}

class AddRecord extends RecordEvent{
  final Record record;
  AddRecord(this.record);
}

class LoadRecords extends RecordEvent{
  final List<Record> records;
  LoadRecords(this.records);
}

class UpdateRecord extends RecordEvent{
  final Record record;
  final int index;

  UpdateRecord(this.record, this.index);
}


