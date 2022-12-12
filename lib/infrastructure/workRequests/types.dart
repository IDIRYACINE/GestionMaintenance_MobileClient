
typedef Callback<T> = void Function(T data);
typedef VoidCallback = void Function();

class WorkRequest<T> {
  WorkRequest(
      {required this.service,
      required this.event,
      required this.data,
      this.responseDataType,
      this.callback,
      this.voidCallback,
      this.hasCallback = false,
      this.hasVoidCallback = false});

  AppServices service;
  Tasks event;
  Type? responseDataType;
  VoidCallback? voidCallback;
  Callback<T>? callback;
  late int workId ;

  bool hasCallback;
  bool hasVoidCallback;
  Map<RequestDataKeys, dynamic> data;

  RequestData toJson(int messageId) {
    return RequestData(
        service: service,
        event: event,
        data: data,
        messageId: messageId);
  }
}

class RequestData{
  RequestData(
      {required this.service,
      required this.event,
      required this.data,
      required this.messageId,
     });
      
  AppServices service;
  Tasks event;

  Map<RequestDataKeys, dynamic> data;

  int messageId;
}


class WorkResult {
  WorkResult(
      {required this.workId,
      required this.status,
      required this.hasData,
      this.data});

  OperationStatus status;
  bool hasData;
  int workId;
  dynamic data;

  Map<WorkResultDataKeys, dynamic> toJson() {
    Map<WorkResultDataKeys, dynamic> json = {};

    json[WorkResultDataKeys.status] = status.name;
    json[WorkResultDataKeys.data] = data;

    return json;
  }
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

enum Tasks{
  saveLocalRecord,
  loadSessionLocalRecords,
  registerScannedBarcode,
}

enum OperationStatus{
  success,
  failure,
  error,
}