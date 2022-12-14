
class ScannedItemData{

  final int barcode;
  final String itemName;
  final String locationName;
  final int locationId;

  ScannedItemData(this.barcode, this.itemName, this.locationName, this.locationId);

  factory ScannedItemData.fromJson(Map<String, dynamic> json) {
    return ScannedItemData(
        json['barcode'],
        json['itemName'],
        json['locationName'],
        json['locationId']
    );
  }
}