import 'dart:convert';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/apis.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'responses.dart';
import 'package:http/http.dart' as http;

class SendBarcodeTask extends ServiceTask<ScannedItemData> {
  late String _apiUrl;

  SendBarcodeTask(String serverUrl) {
    _apiUrl = '$serverUrl/${Apis.postSingleBarcode}';
  }

  @override
  Future<ScannedItemData> execute(requestData) async {
    Barcode barcode = requestData as Barcode;
  

    return http
        .post(Uri.parse(_apiUrl), body: barcode.toJson())
        .then((responseJson) {
      ScannedItemData response =
          ScannedItemData.fromJson(jsonDecode(responseJson.body));
      return response;
    });
  }
}

class AuthenticateTask {}
