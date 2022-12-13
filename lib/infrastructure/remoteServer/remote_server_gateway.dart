import 'package:gestion_maintenance_mobile/infrastructure/forwarder.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'remote_server.dart';
import 'types.dart';

class RemoteServerGateway extends ServiceHandler {
  final List<ServiceTask> _services = [];
  final String _serverUrl;

  RemoteServerGateway(this._serverUrl) {
    _registerTasks();
  }

  @override
  Future<dynamic> handleMessage(RequestData message) async {
    return _services[message.task.index].execute(message.data).then((result) {
      return result;
    });
  }

  void _registerTasks() {
    _services[RemoteServerTasks.sendBarcode.index] = SendBarcodeTask(_serverUrl);
  }
}
