import 'dart:convert';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/apis.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'responses.dart';
import 'package:http/http.dart' as http;

class SendBarcodeTask extends ServiceTask<WorkResult> {

  SendBarcodeTask(String serverUrl) ;

  @override
  Future<WorkResult> execute(requestData) async {
    int barcode = requestData[RequestDataKeys.barcode];
    DateTime date = requestData[RequestDataKeys.scannedDate];

    final json = jsonEncode(
        {"barcode": barcode.toString(), "scannedDate": date.toIso8601String()});

    return http.post(
      Uri.http(Apis.serverUrl,Apis.submitRecord),
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

class AuthenticateTask extends ServiceTask<WorkResult> {
  final String serverUrl;

  AuthenticateTask(this.serverUrl) ;

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
            print(responseJson.body);

      LoginResponse response =
          LoginResponse.fromJson(jsonDecode(responseJson.body));
      

      return WorkResult(
          workId: -1, status: OperationStatus.success, data: response);
    }).onError((error, stackTrace) => WorkResult(
        workId: -1, status: OperationStatus.error, data: error.toString()));
  }
}
