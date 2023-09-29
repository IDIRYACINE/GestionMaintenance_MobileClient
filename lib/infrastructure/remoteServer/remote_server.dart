import 'dart:convert';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/apis.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'responses.dart';
import 'package:http/http.dart' as http;

class SendBarcodeTask extends ServiceTask<WorkResult> {
  final String serverUrl;

  SendBarcodeTask(this.serverUrl);

  @override
  Future<WorkResult> execute(requestData) async {
    int barcode = requestData[RequestDataKeys.barcode];

    final json = jsonEncode({
      RequestDataKeys.barcode.name: barcode,
      RequestDataKeys.workerId.name: requestData[RequestDataKeys.workerId],
    });

    // final res = '{"barcode":91080687,"code":0,"itemName":"EXTENTION HONGAR 500 M²","locationId":"53","locationName":"53"}';


    return http.post(
      Uri.https(serverUrl, Apis.submitRecord),
      body: json,
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((responseJson) {
      ScannedItemData response =
          ScannedItemData.fromJson(jsonDecode(responseJson.body));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace) { 
      return WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString());
        });
  }
}

class SendBarcodeBatchTask extends ServiceTask<WorkResult> {
  final String serverUrl;

  SendBarcodeBatchTask(this.serverUrl);

  @override
  Future<WorkResult> execute(requestData) async {
    List<int> barcodes = requestData[RequestDataKeys.barcodes];

    final json = jsonEncode({
      RequestDataKeys.barcodes.name: barcodes,
      RequestDataKeys.workerId.name: requestData[RequestDataKeys.workerId],
      RequestDataKeys.groupId.name: requestData[RequestDataKeys.groupId]
    });

    return http.post(
      Uri.https(serverUrl, Apis.submitRecord),
      body: json,
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((responseJson) {
      List<ScannedItemData> response = List<ScannedItemData>.from(
          jsonDecode(responseJson.body)
              .map((x) => ScannedItemData.fromJson(x)));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace) => WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class AuthenticateTask extends ServiceTask<WorkResult> {
  final String serverUrl;

  AuthenticateTask(this.serverUrl);

  @override
  Future<WorkResult> execute(requestData) {
    String username = requestData[RequestDataKeys.username];
    String password = requestData[RequestDataKeys.password];


    return http.get(
      Uri.https(serverUrl, Apis.authenticate),
      headers: {
        'Content-Type': 'application/json',
        'Username' : username,
        'Password' :password
      },
    ).then((responseJson) {
      LoginResponse response =
          LoginResponse.fromJson(jsonDecode(responseJson.body));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace)  {
      return WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString());
    });
  }
}
