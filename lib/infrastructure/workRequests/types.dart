

typedef Callback<T> = void Function(T data);
typedef VoidCallback = void Function();

class WorkRequest<T> {
  WorkRequest(
      {required this.service,
      required this.task,
      required this.data,
      this.responseDataType,
      this.callback,
      this.voidCallback,
      this.hasCallback = false,
      this.hasVoidCallback = false});

  AppServices service;
  Task task;
  Type? responseDataType;
  VoidCallback? voidCallback;
  Callback<T>? callback;
  late int workId ;

  bool hasCallback;
  bool hasVoidCallback;
  dynamic data;

  RequestData toJson(int messageId) {
    return RequestData(
        service: service,
        task: task,
        data: data,
        messageId: messageId);
  }
}

class RequestData{
  RequestData(
      {required this.service,
      required this.task,
      required this.data,
      required this.messageId,
     });
      
  AppServices service;
  Task task;

  Map<RequestDataKeys, dynamic> data;

  int messageId;
}


class WorkResult {
  WorkResult(
      {required this.workId,
      required this.status,
      this.data});

  OperationStatus status;
  int workId;
  dynamic data;

  Map<WorkResultDataKeys, dynamic> toJson() {
    Map<WorkResultDataKeys, dynamic> json = {};

    json[WorkResultDataKeys.status] = status.name;
    json[WorkResultDataKeys.data] = data;

    return json;
  }
}

abstract class ServiceTask<T>{
  Future<T> execute(dynamic requestData);
}

enum WorkResultDataKeys{
  status,
  hasData,
  data,
  workId
}

enum AppServices {
  remoteServer,
  localDatabase
}

enum RequestDataKeys{
  barcode,
  record,
  records,
  name,
  id,
  count,
  scannedDate,
  barcodes,
  workerId,
  workerName
}

enum OperationStatus{
  success,
  failure,
  error,
}

class Task {
  final int index;
  final String name;
  Task(this.index, this.name);
}