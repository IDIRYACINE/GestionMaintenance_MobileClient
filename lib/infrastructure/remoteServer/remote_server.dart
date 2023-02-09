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
    DateTime date = requestData[RequestDataKeys.scannedDate];

    final json = jsonEncode({
      RequestDataKeys.barcode.name: barcode.toString(),
      RequestDataKeys.scannedDate.name: date.toIso8601String(),
      RequestDataKeys.workerId.name: requestData[RequestDataKeys.workerId],
      RequestDataKeys.workerName.name: requestData[RequestDataKeys.workerName],
      RequestDataKeys.permissions.name:
          requestData[RequestDataKeys.permissions],
      RequestDataKeys.groupId.name: requestData[RequestDataKeys.groupId]
    });

    return http.post(
      Uri.http(serverUrl, Apis.submitRecord),
      body: json,
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((responseJson) {
      ScannedItemData response =
          ScannedItemData.fromJson(jsonDecode(responseJson.body));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace) => WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}

class SendBarcodeBatchTask extends ServiceTask<WorkResult> {
  final String serverUrl;

  SendBarcodeBatchTask(this.serverUrl);

  @override
  Future<WorkResult> execute(requestData) async {
    List<int> barcodes = requestData[RequestDataKeys.barcodes];
    DateTime date = requestData[RequestDataKeys.scannedDate];

    final json = jsonEncode({
      RequestDataKeys.barcodes.name: barcodes.toString(),
      RequestDataKeys.scannedDate.name: date.toIso8601String(),
      RequestDataKeys.workerId.name: requestData[RequestDataKeys.workerId],
      RequestDataKeys.workerName.name: requestData[RequestDataKeys.workerName],
      RequestDataKeys.permissions.name:
          requestData[RequestDataKeys.permissions],
      RequestDataKeys.groupId.name: requestData[RequestDataKeys.groupId]
    });

    return http.post(
      Uri.http(serverUrl, Apis.submitRecord),
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

    final query = {
      'username': username,
      'password': password,
    };

    return http.get(
      Uri.http(serverUrl, Apis.authenticate, query),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((responseJson) {
      LoginResponse response =
          LoginResponse.fromJson(jsonDecode(responseJson.body));

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace) => WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}
