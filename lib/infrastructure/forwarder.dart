import 'dart:isolate';

import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

import 'remoteServer/remote_server_gateway.dart';

class ServicesForwarder {
  ServicesForwarder({required this.uiThreadPort,required String storagePath}) {
    _initialseServicesSlots();
    _registerServices(storagePath);
  }

  final SendPort uiThreadPort;
  final List<ServiceHandler> services = [];

  void handleMessage(RequestData message) {
    services[message.service.index].handleMessage(message).then((response) {
      
      if (response != null) uiThreadPort.send(response);
    });
  }

  void _registerServices(String storagePath) {
    services[AppServices.remoteServer.index] = RemoteServerGateway();

    SqliteDatabase db = SqliteDatabase(storagePath);
    db.init();
    services[AppServices.localDatabase.index] = db;
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
