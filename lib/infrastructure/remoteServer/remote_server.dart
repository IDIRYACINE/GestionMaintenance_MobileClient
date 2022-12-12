
import 'package:gestion_maintenance_mobile/data/barcode.dart';

import 'types.dart';

class Server implements RemoteServer{
  
  @override
  Future<bool> authenticate({required String username, required String password}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<void> sendBarcode({required Barcode barcode}) {
    // TODO: implement sendBarcode
    throw UnimplementedError();
  }

  @override
  Future<void> sendRecord({required Record record}) {
    // TODO: implement sendRecord
    throw UnimplementedError();
  }

}