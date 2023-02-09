import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/data/worker.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/responses.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/types.dart';
import 'types.dart';

abstract class RemoteServerRequestBuilder {
  static WorkRequest<ScannedItemData> sendScannedBarcode(
      {required Barcode barcode,
      required Worker worker,
      required Callback<ScannedItemData> onResponse}) {
    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.barcode: barcode.barcode,
      RequestDataKeys.scannedDate: barcode.scannedDate,
      RequestDataKeys.workerId: worker.workerId,
      RequestDataKeys.workerName: worker.workerName,
      RequestDataKeys.permissions: worker.permissions,
      RequestDataKeys.groupId: worker.groupId,
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

  static WorkRequest<LoginResponse> validateLogin(
      {required String username,
      required String password,
      required Callback<LoginResponse> onResponse}) {
    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.username: username,
      RequestDataKeys.password: password
    };

    Task task = Task(RemoteServerTasks.authenticate.index,
        RemoteServerTasks.authenticate.name);

    return WorkRequest<LoginResponse>(
        service: AppServices.remoteServer,
        task: task,
        data: data,
        hasCallback: true,
        callback: onResponse);
  }

  static WorkRequest sendScannedBarcodeBatch(
      {required List<Barcode> barcodes,
      required Worker worker,
      required void Function(List<ScannedItemData> data) onResponse}) {
    final rawBarcodes = barcodes.map((e) => e.barcode).toList();
    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.barcodes: rawBarcodes,
      RequestDataKeys.scannedDate: barcodes.first.scannedDate,
      RequestDataKeys.workerId: worker.workerId,
      RequestDataKeys.workerName: worker.workerName,
      RequestDataKeys.permissions: worker.permissions,
      RequestDataKeys.groupId: worker.groupId,
    };

    Task task = Task(RemoteServerTasks.sendBarcode.index,
        RemoteServerTasks.sendBarcodeBatch.name);

    return WorkRequest<List<ScannedItemData>>(
        service: AppServices.remoteServer,
        task: task,
        data: data,
        hasCallback: true,
        callback: onResponse);
  }
}
