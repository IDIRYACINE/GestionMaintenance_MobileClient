import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/localDatabase/local_database.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

abstract class LocalDatabaseRequestBuilder {
  static WorkRequest<void> insertBarcodeIntoWaitingQueue(
      {required Barcode barcode}) {
    Task task = Task(LocalDatabaseTasks.insertBarcodeIntoWaitingQueue.index,
        LocalDatabaseTasks.insertBarcodeIntoWaitingQueue.name);

    Map<RequestDataKeys, dynamic> data = {RequestDataKeys.barcode: barcode};

    return WorkRequest<void>(
      service: AppServices.localDatabase,
      task: task,
      data: data,
    );
  }

  static WorkRequest<List<Barcode>> loadBarcodeWaitingQueue(
      {required Callback<List<Barcode>> callback}) {
    Task task = Task(LocalDatabaseTasks.loadBarcodeWaitingQueue.index,
        LocalDatabaseTasks.loadBarcodeWaitingQueue.name);

    return WorkRequest<List<Barcode>>(
        service: AppServices.localDatabase,
        task: task,
        data: null,
        callback: callback,
        hasCallback: true);
  }

  static WorkRequest<void> deleteBarcodeFromWaitingQueue(
      {required Barcode barcode}) {
    Task task = Task(LocalDatabaseTasks.deleteBarcodeFromWaitingQueue.index,
        LocalDatabaseTasks.deleteBarcodeFromWaitingQueue.name);

    Map<RequestDataKeys, dynamic> data = {RequestDataKeys.barcode: barcode};

    return WorkRequest<void>(
      service: AppServices.localDatabase,
      task: task,
      data: data,
    );
  }

  static WorkRequest<void> insertBarcodeIntoScanned(
      {required Barcode barcode, required Record record}) {
    Task task = Task(LocalDatabaseTasks.insertBarcodeIntoScanned.index,
        LocalDatabaseTasks.insertBarcodeIntoScanned.name);

    Map<RequestDataKeys, dynamic> data = {
      RequestDataKeys.barcode: barcode,
      RequestDataKeys.record: record
    };

    return WorkRequest<void>(
      service: AppServices.localDatabase,
      task: task,
      data: data,
    );
  }

  static WorkRequest<void> insertDesignation({required Record record}) {
    Task task = Task(LocalDatabaseTasks.insertDesignation.index,
        LocalDatabaseTasks.insertDesignation.name);

    Map<RequestDataKeys, dynamic> data = {RequestDataKeys.record: record};

    return WorkRequest<void>(
      service: AppServices.localDatabase,
      task: task,
      data: data,
    );
  }

  static WorkRequest<List<Barcode>> loadScannedBarcodes(
      {required Callback<List<Barcode>> callback}) {
    Task task = Task(LocalDatabaseTasks.loadScannedBarcodes.index,
        LocalDatabaseTasks.loadScannedBarcodes.name);

    return WorkRequest<List<Barcode>>(
        service: AppServices.localDatabase,
        task: task,
        data: null,
        hasCallback: true,
        callback: callback);
  }

  static WorkRequest<void> updateWaitingBarcodeState(
      {required Barcode barcode}) {
    Map<RequestDataKeys, dynamic> data = {RequestDataKeys.barcode: barcode};

    Task task = Task(LocalDatabaseTasks.updateWaitingBarcodeState.index,
        LocalDatabaseTasks.updateWaitingBarcodeState.name);

    return WorkRequest<void>(
      service: AppServices.localDatabase,
      task: task,
      data: data,
    );
  }
}
