import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordEvent{}

class AddRecord extends RecordEvent{
  final Record record;
  AddRecord(this.record);
}

class LoadRecords extends RecordEvent{
  final Map<String,Record> records;
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

class LoadWaitingBarcodes extends RecordEvent{
  final List<Barcode> barcodes;

  LoadWaitingBarcodes(this.barcodes);
}

class UpdateBarcode extends RecordEvent{
  final Barcode barcode;
  final String locationId;
  final String locationName;

  UpdateBarcode(this.barcode, this.locationId, this.locationName);
}

class UpdateBarcodeBatch extends RecordEvent{
  final Map<String , BarcodeBatch> batch;

  UpdateBarcodeBatch(this.batch);
}

class BarcodeAlreadyScanned extends RecordEvent{
  final Barcode barcode;

  BarcodeAlreadyScanned(this.barcode);
}

class BatchSubmitScannedItems extends RecordEvent{
  BatchSubmitScannedItems();
}

