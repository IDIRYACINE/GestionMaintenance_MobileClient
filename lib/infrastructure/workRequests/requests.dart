import 'package:gestion_maintenance_mobile/data/barcode.dart';

import 'types.dart';



abstract class RequestBuilder {
  static WorkRequest sendScannedBarcode(
      {required Barcode barcode, required Callback<ScannedItemData> onResponse}) {

    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.barcode: barcode.barcode,
      RequestDataKeys.scannedDate: barcode.scannedDate
    };

    return WorkRequest<ScannedItemData>(
        service: AppServices.remoteServer,
        event: Tasks.registerScannedBarcode,
        data: data,
        hasCallback: true,
        callback: onResponse
        );
  }
}

class ScannedItemData{
  final int locationId;
  final String itemName;
  final int barcode;
  final String locationName;


  ScannedItemData(this.locationId, this.itemName, this.barcode, this.locationName);
}
