import 'dart:isolate';

import 'forwarder.dart';
import 'workRequests/types.dart';

class ServicesCenter {

  ServicesCenter._(){
    ReceivePort uiPort = ReceivePort();

    uiPort.listen((message) {
      if (message is SendPort) {
        _backgroundThreadPort = message;

        return;
      }

      _receiveMessage(message);
    });

    Isolate.spawn(registerPort, uiPort.sendPort).then((isolate) {
      _isolateBackground = isolate;
    });
  }
  


  late SendPort _backgroundThreadPort;

  // ignore: unused_field
  late Isolate _isolateBackground;


  final List<WorkRequest> _workRequests = [];
  int _requestsCounter = 0;

  static ServicesCenter? _instance;

  factory ServicesCenter.instance() {
    _instance ??= ServicesCenter._();
    return _instance!;
  }

  Future<void> emitWorkRequest<T> (WorkRequest<T> workRequest) async {
    _workRequests.add(workRequest);
    workRequest.workId = _requestsCounter;
    _requestsCounter += 1;
    _backgroundThreadPort.send(workRequest.toJson(workRequest.workId));
  }


  void registerPort(SendPort sendPort) async {
    ReceivePort servicePort = ReceivePort();

    ServicesForwarder eventsForwarder =
        ServicesForwarder(uiThreadPort: sendPort);

    sendPort.send(servicePort.sendPort);

    servicePort.listen((message) {
      eventsForwarder.handleMessage(message);
    });
  }


  void _receiveMessage(WorkResult response) {
    // using dyanamic type checking to avoid runtime errors ,
    // otherwise message generic type is casted to dynamic instead of T
    dynamic workRequest = _binarySearchWorkRequest(response.workId);

    if(workRequest == null){
      return;
    }

    if (workRequest.hasCallback) {
      workRequest.callback?.call(response.data);
    }

    if (workRequest.hasVoidCallback) {
      workRequest.voidCallback?.call();
    }

    _workRequests.remove(workRequest);
  }

  WorkRequest? _binarySearchWorkRequest(int workId){
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