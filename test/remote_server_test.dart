// ignore_for_file: unused_element

import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/responses.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/remote_server_requests.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

void main() {
  
  void sendBarcodeAndReceiveResponse() {
    test('send barcode and receive response', () async {
      ServicesCenter.instance();
      Barcode dummyBarcode =
          Barcode(barcode: 23456789, scannedDate: DateTime.now());

      void onResponse(ScannedItemData scannedItemData) {
        expect(scannedItemData.barcode, dummyBarcode.barcode);
      }

      WorkRequest sendBarcodeTask =
          RemoteServerRequestBuilder.sendScannedBarcode(
              barcode: dummyBarcode, onResponse: onResponse);

      ServicesCenter.instance().emitWorkRequest(sendBarcodeTask);
    });
  }
}
