import 'package:gestion_maintenance_mobile/infrastructure/forwarder.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/remote_server_requests.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'apis.dart';
import 'remote_server.dart';
import 'types.dart';

class RemoteServerGateway extends ServiceHandler {
  final List<ServiceTask> _services = [];
  final String _serverUrl = Apis.serverUrl;

  RemoteServerGateway() {
    _initialiseTaskSlots();
    _registerTasks();
  }

  @override
  Future<dynamic> handleMessage(RequestData message) async {
    return _services[message.task.index].execute(message.data).then((value) {
      WorkResult result = value as WorkResult;

      result.workId = message.messageId;

      return result;
    });
  }

  void _registerTasks() {
    _services[RemoteServerTasks.sendBarcode.index] =
        SendBarcodeTask(_serverUrl);

    _services[RemoteServerTasks.authenticate.index] =
        AuthenticateTask(_serverUrl);
  }

  void _initialiseTaskSlots() {
    EmptyTask emptyTask = EmptyTask();
    for (int i = 0; i < RemoteServerTasks.values.length; i++) {
      _services.add(emptyTask);
    }
  }
}
