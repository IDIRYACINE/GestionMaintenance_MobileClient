import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/forwarder.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/responses.dart';
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

  static WorkRequest validateLogin(
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
}

class EmptyTask extends ServiceTask {
  @override
  Future execute(requestData) {
    throw UnimplementedError();
  }
}

class EmptyService extends ServiceHandler {
  @override
  Future<dynamic> handleMessage(RequestData message) {
    throw UnimplementedError();
  }
}
