import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/types.dart';

import 'types.dart';

abstract class RemoteServerRequestBuilder {
  
  static WorkRequest sendScannedBarcode(
      {required Barcode barcode,
      required Callback<ScannedItemData> onResponse}) {
    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.barcode: barcode.barcode,
      RequestDataKeys.scannedDate: barcode.scannedDate
    };

    Task task = Task(RemoteServerTasks.sendBarcode.index,
        RemoteServerTasks.sendBarcode.name);

    return WorkRequest<ScannedItemData>(
        service: AppServices.remoteServer,
        task: task,
        data: data,
        hasCallback: true,
        callback: onResponse);
  }
}

class ScannedItemData {
  final int locationId;
  final String itemName;
  final int barcode;
  final String locationName;

  ScannedItemData(
      this.locationId, this.itemName, this.barcode, this.locationName);
}

