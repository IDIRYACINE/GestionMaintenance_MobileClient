
class StockProduct{
  int stockId;
  String productName;

  StockProduct({required this.stockId, required this.productName});
}

class InventoryProduct{
  int stockId;
  int inventoryId;
  int barcode;
  
  InventoryProduct({required this.stockId, required this.inventoryId, required this.barcode});
}

class FamilyCode{
  int code;
  String name;
  FamilyCode({required this.code, required this.name});
}