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
  final String? workerName;
  final int? departement;
  final bool errorOccured;

  LoginResponse(
      {required this.authenticated,
      this.workerId,
      this.workerName,
      this.departement,
      this.errorOccured = false});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        authenticated: json['authenticated'],
        workerId: json['workerId'],
        workerName: json['workerName'],
        departement: json['departement'],
        errorOccured: json['errorOccured'] ?? false);
  }
}
