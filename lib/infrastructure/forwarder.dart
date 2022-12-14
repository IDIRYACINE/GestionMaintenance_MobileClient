import 'dart:isolate';

import 'package:gestion_maintenance_mobile/infrastructure/workRequests/remote_server_requests.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'remoteServer/remote_server_gateway.dart';

class ServicesForwarder {
  ServicesForwarder({required this.uiThreadPort}) {
    _initialseServicesSlots();
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
    services[AppServices.remoteServer.index] = RemoteServerGateway();
  }

  void _initialseServicesSlots() {
    for (int i = 0; i < AppServices.values.length; i++) {
      services.add(EmptyService());
    }
  }
}

abstract class ServiceHandler {
  Future<dynamic> handleMessage(RequestData message);
}
