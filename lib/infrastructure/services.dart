import 'dart:isolate';


import 'forwarder.dart';
import 'workRequests/types.dart';

class ServicesCenter {
  ServicesCenter._(String storagePath) {
    ReceivePort uiPort = ReceivePort();

    uiPort.listen((message) {
      if (message is SendPort) {
        _backgroundThreadPort = message;

        return;
      }

      _receiveMessage(message);
    });

    IsolateParams data =
        IsolateParams(
            uiThreadPort: uiPort.sendPort, storagePath: storagePath);

    Isolate.spawn(registerPort, data).then((isolate) {
      _isolateBackground = isolate;
    });
  }

  late SendPort _backgroundThreadPort;

  // ignore: unused_field
  late Isolate _isolateBackground;

  final List<WorkRequest> _workRequests = [];
  int _requestsCounter = 0;

  static ServicesCenter? _instance;

  factory ServicesCenter.instance({String? storagePath}) {
    assert(
        (_instance == null && storagePath != null) ||
            (_instance != null && storagePath == null),
        'ServicesCenter must be initialised first');
    _instance ??= ServicesCenter._(storagePath!);
    return _instance!;
  }

  Future<void> emitWorkRequest<T>(WorkRequest<T> workRequest) async {
    _workRequests.add(workRequest);
    workRequest.workId = _requestsCounter;
    _requestsCounter += 1;
    _backgroundThreadPort.send(workRequest.toJson(workRequest.workId));
  }

  void registerPort(IsolateParams data) async {
    ReceivePort servicePort = ReceivePort();

    ServicesForwarder eventsForwarder = ServicesForwarder(
        uiThreadPort: data.uiThreadPort, storagePath: data.storagePath);

    data.uiThreadPort.send(servicePort.sendPort);

    servicePort.listen((message) {
      eventsForwarder.handleMessage(message);
    });
  }

  void _receiveMessage(WorkResult response) {
    if (response.status == OperationStatus.error) {
      return;
    }

    // using dyanamic type checking to avoid runtime errors ,
    // otherwise message generic type is casted to dynamic instead of T
    dynamic workRequest = _binarySearchWorkRequest(response.workId);

    if (workRequest.hasCallback) {
      workRequest.callback?.call(response.data);
    }

    if (workRequest.hasVoidCallback) {
      workRequest.voidCallback?.call();
    }

    _workRequests.remove(workRequest);
  }

  WorkRequest? _binarySearchWorkRequest(int workId) {
    int min = 0;
    int max = _workRequests.length - 1;

    while (min <= max) {
      int mid = (min + max) ~/ 2;
      int midVal = _workRequests[mid].workId;

      if (midVal < workId) {
        min = mid + 1;
      } else if (midVal > workId) {
        max = mid - 1;
      } else {
        return _workRequests[mid];
      }
    }

    return null;
  }
}

class IsolateParams {
  final SendPort uiThreadPort;
  final String storagePath;

  IsolateParams(
      {required this.uiThreadPort, required this.storagePath});
}
