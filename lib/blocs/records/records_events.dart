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

class AddBarcode extends RecordEvent{
  final int barcode;

  AddBarcode(this.barcode);
}

class UpdateBarcode extends RecordEvent{
  final Barcode barcode;
  final int locationId;

  UpdateBarcode(this.barcode, this.locationId);
}


