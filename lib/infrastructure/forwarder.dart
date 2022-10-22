import 'dart:isolate';

class ServicesForwarder{
  ServicesForwarder({required this.uiThreadPort});

  final SendPort uiThreadPort;

  void handleMessage(dynamic message) {
    
  }

  
}