import 'dart:isolate';

import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

class ServicesForwarder {
  ServicesForwarder({required this.uiThreadPort}) {
    _registerServices();
  }

  final SendPort uiThreadPort;
  final Map<AppServices, ServiceHandler> services = {};

  void handleMessage(WorkRequest message) {
    services[message.service]?.handleMessage(message).then((response) {
      if (response != null) uiThreadPort.send(response);
    });
  }

  void _registerServices() {}
}

abstract class ServiceHandler {
  Future<dynamic> handleMessage(WorkRequest message);
}
