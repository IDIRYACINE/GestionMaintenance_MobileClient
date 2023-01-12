
class ScannedItemData {
  final int barcode;
  final String itemName;
  final String locationName;
  final int locationId;

  ScannedItemData(
      this.barcode, this.itemName, this.locationName, this.locationId);

  factory ScannedItemData.fromJson(Map<String, dynamic> json) {
    return ScannedItemData(json['barcode'], json['itemName'],
        json['locationName'], json['locationId']);
  }
}

class LoginResponse {
  final bool authenticated;
  final int? workerId;
  final int? groupId;
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
      List<int> permissions = List.from(json['departementId']?? []);

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
