import 'dart:async';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/core/extensions/sound_player.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/core/extensions/vibrator.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/data/worker.dart';
import 'package:gestion_maintenance_mobile/features/login/state/bloc.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/responses.dart';
import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/types.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/remote_server_requests.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';
import 'package:gestion_maintenance_mobile/features/themes/constants.dart';
import 'types.dart';

class BarcodeCenter implements BarcodeManger {
  RecordsBloc recordsBloc;
  AuthBloc authBloc;
  BarcodeCenter._(this.recordsBloc, this.authBloc);

  static BarcodeCenter? _instance;

  factory BarcodeCenter.instance(
      {RecordsBloc? recordsBloc, AuthBloc? authBloc}) {
    assert(
        (recordsBloc != null && _instance == null) ||
            (recordsBloc == null && _instance != null),
        "First call detected  : You must provide a recordsBloc to initialize the BarcodeCenter ");
    assert(
        (authBloc != null && _instance == null) ||
            (authBloc == null && _instance != null),
        "First call detected  : You must provide a authBloc to initialize the BarcodeCenter ");

    _instance ??= BarcodeCenter._(recordsBloc!, authBloc!);
    return _instance!;
  }

  static initExtensions(SettingsState state) {
    if (_instance == null) return;
    _instance!._extensions.clear();

    bool playSound = state.playSoundSetting.enabled;

    if (playSound) {
      SoundPlayerExtension soundPlayer = SoundPlayerExtension.instance();
      soundPlayer.setAsset(onScanBarcodeSound);
      _instance!.addExtension(soundPlayer);
    }

    bool vibrate = state.vibrateOnScanSetting.enabled;
    if (vibrate) {
      _instance!.addExtension(VibratorExtension.instance());
    }

    _instance!.addExtension(ToasterExtension.instance());
  }

  final List<BarcodeSubscriber> _subscribers = [];
  final List<BarcodeCenterExtension> _extensions = [];

  @override
  Future<void> emitBarcode(String barcode) async {
    for (BarcodeCenterExtension bExtension in _extensions) {
      bExtension.onBarcode(barcode);
    }
    int ibarcode = int.parse(barcode);
    _registerBarcode(ibarcode);
  }

  @override
  void subscribeToBarcodeStream(BarcodeSubscriber subscriber) {
    _subscribers.add(subscriber);
  }

  @override
  void unSubscribeToBarcodeStream(BarcodeSubscriber subscriber) {
    _subscribers.remove(subscriber);
  }

  @override
  void addExtension(BarcodeCenterExtension bExtension) {
    _extensions.add(bExtension);
  }

  @override
  void removeExtension(BarcodeCenterExtension bExtension) {
    _extensions.remove(bExtension);
  }

  void _registerBarcode(int barcode) {
    recordsBloc.add(AddBarcode(barcode));

    Barcode mBarcode = Barcode(barcode: barcode, scannedDate: DateTime.now());

    Worker worker = Worker(
        workerId: authBloc.state.workerId,
        workerName: authBloc.state.workerName,
        groupId: authBloc.state.groupId,
        permissions: authBloc.state.workerDepartmentIds);

    WorkRequest submitScannedBarcode =
        RemoteServerRequestBuilder.sendScannedBarcode(
            barcode: mBarcode,
            worker: worker,
            onResponse: _onBarcodeDataReceived);

    ServicesCenter.instance().emitWorkRequest(submitScannedBarcode);
  }

  void _onBarcodeDataReceived(ScannedItemData data) {
    Record record =
        recordsBloc.state.records[RecordState.pendingItemsRecordIndex]!;

    Barcode? updatedBarcode = record.barcodes[data.barcode];
    if (updatedBarcode == null) return;

    if (data.status != BarcodeTaskStatus.alreadyScanned) {
      updatedBarcode = updatedBarcode.copyWith(
        state: BarcodeStates.loaded,
        name: data.itemName,
      );

      UpdateBarcode event =
          UpdateBarcode(updatedBarcode, data.locationId, data.locationName);
      recordsBloc.add(event);

      return;
    }

    BarcodeAlreadyScanned event =
        BarcodeAlreadyScanned(updatedBarcode);

    recordsBloc.add(event);
  }
}
