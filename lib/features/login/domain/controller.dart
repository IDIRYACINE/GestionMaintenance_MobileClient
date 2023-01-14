import 'package:flutter/cupertino.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/core/navigation/navigator.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/local_database_request.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

class Controller {

  final RecordsBloc _recordsBloc;

  Controller(this._recordsBloc);

  Future<void> loadData(BuildContext context) async {
    final serviceCenter = ServicesCenter.instance();

    WorkRequest loadWaiting =
        LocalDatabaseRequestBuilder.loadBarcodeWaitingQueue(
            callback: _onLoadedWaitingQueue);
    serviceCenter.emitWorkRequest(loadWaiting);

    // WorkRequest loadScannedBarcodes = LocalDatabaseRequestBuilder.loadScannedBarcodes();
    // serviceCenter.emitWorkRequest(loadScannedBarcodes);
  }

  Future<void> _onLoadedWaitingQueue(List<Barcode> barcodes) async {
    _recordsBloc.add(LoadWaitingBarcodes(barcodes));
    AppNavigator.pop();
  }
}
