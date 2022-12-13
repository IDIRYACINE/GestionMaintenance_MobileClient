import 'dart:isolate';

import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'remoteServer/remote_server_gateway.dart';

class ServicesForwarder {
  ServicesForwarder({required this.uiThreadPort}) {
    _registerServices();
  }

  final SendPort uiThreadPort;
  final List<ServiceHandler> services = [];

  void handleMessage(RequestData message) {
    services[message.service.index].handleMessage(message).then((response) {
      
      if (response != null) uiThreadPort.send(response);
    });
  }

  void _registerServices() {
    services[AppServices.remoteServer.index] = RemoteServerGateway('');
  }
}

abstract class ServiceHandler {
  Future<dynamic> handleMessage(RequestData message);
}
