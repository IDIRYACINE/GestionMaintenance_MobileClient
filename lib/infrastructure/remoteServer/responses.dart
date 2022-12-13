
class BarcodeResponse{

  final int barcode;
  final String itemName;
  final String locationName;
  final int locationId;

  BarcodeResponse(this.barcode, this.itemName, this.locationName, this.locationId);

  factory BarcodeResponse.fromJson(Map<String, dynamic> json) {
    return BarcodeResponse(
        json['barcode'],
        json['itemName'],
        json['locationName'],
        json['locationId']
    );
  }
}