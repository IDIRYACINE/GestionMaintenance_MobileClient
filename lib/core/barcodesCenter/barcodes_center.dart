import 'dart:async';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/core/extensions/sound_player.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/core/extensions/vibrator.dart';
import 'package:gestion_maintenance_mobile/ui/themes/constants.dart';
import 'types.dart';

class BarcodeCenter implements BarcodeManger {
  RecordsBloc recordsBloc;
  BarcodeCenter._(this.recordsBloc);

  static BarcodeCenter? _instance;

  factory BarcodeCenter.instance({RecordsBloc? recordsBloc}) {
    assert(
        (recordsBloc != null && _instance == null) ||
            (recordsBloc == null && _instance != null),
        "First call detected  : You must provide a recordsBloc to initialize the BarcodeCenter ");

    _instance ??= BarcodeCenter._(recordsBloc!);
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
  }
}
