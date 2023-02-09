import 'package:gestion_maintenance_mobile/infrastructure/forwarder.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'apis.dart';
import 'remote_server.dart';
import 'types.dart';

class RemoteServerGateway extends ServiceHandler {
  final List<ServiceTask> _services = [];
  late String _serverUrl ;

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

  Future<void> _registerTasks() async {
    _serverUrl = await Apis.serverUrl;

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
