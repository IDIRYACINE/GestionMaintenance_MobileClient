import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/types.dart';

class ScannedItemData {
  final int barcode;
  final String itemName;
  final String locationName;
  final String locationId;
  final BarcodeTaskStatus status;

  ScannedItemData(this.barcode, this.itemName, this.locationName,
      this.locationId, this.status);

  factory ScannedItemData.fromJson(Map<String, dynamic> json) {
    ScannedItemData data;
    List<BarcodeTaskStatus> status = BarcodeTaskStatus.values;

    try {
      int statusIndex = json['code'] ?? 0;

      data = ScannedItemData(json['barcode'], json['itemName'],
          json['locationName'], json['locationId'], status[statusIndex]);
    } catch (e) {
      data = ScannedItemData(-1, '', '', 'None',status[BarcodeTaskStatus.alreadyScanned.index]);
    }

    return data;
  }
}

class LoginResponse {
  final bool authenticated;
  final String? workerId;
  final String? groupId;
  final String? workerName;
  final List<int>? departement;
  final bool errorOccured;

  LoginResponse(
      {required this.authenticated,
      this.workerId,
      this.groupId,
      this.workerName,
      this.departement,
      this.errorOccured = false});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    LoginResponse loginResponse;
    try {
      List<int> permissions = List.from(json['departementId'] ?? []);

      loginResponse = LoginResponse(
          authenticated: json['authenticated'],
          workerId: json['workerId'],
          workerName: json['workerName'],
          departement: permissions,
          groupId: json['groupId'],
          errorOccured: json['errorOccured'] ?? false);
    } catch (e) {
      loginResponse = LoginResponse(authenticated: false, errorOccured: true);
    }

    return loginResponse;
  }
}
