import 'dart:convert';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/apis.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'responses.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart';

class SendBarcodeTask extends ServiceTask<WorkResult> {
  late String _apiUrl;

  SendBarcodeTask(String serverUrl) {
    _apiUrl = '$serverUrl${Apis.submitRecord}';
  }

  @override
  Future<WorkResult> execute(requestData) async {
    int barcode = requestData[RequestDataKeys.barcode];
    DateTime date = requestData[RequestDataKeys.scannedDate];

    

    final json = jsonEncode(
        {"barcode": barcode.toString(), "scannedDate": date.toIso8601String()});

    return http.post(
      Uri.parse(_apiUrl),
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

class AuthenticateTask {}
