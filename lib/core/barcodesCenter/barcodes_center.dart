import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/settings_state.dart';
import 'package:gestion_maintenance_mobile/core/extensions/sound_player.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/core/extensions/vibrator.dart';
import 'package:gestion_maintenance_mobile/ui/themes/constants.dart';
import 'types.dart';

class BarcodeCenter implements BarcodeManger{

  BarcodeCenter._();

  static BarcodeCenter? _instance ;

  factory BarcodeCenter.instance() {
    _instance ??= BarcodeCenter._();
    return _instance!;
  }

  static initExtensions(SettingsState state){
    if(_instance == null) return;
    _instance!._extensions.clear();

    bool playSound = state.playSoundSetting.enabled;
    if(playSound){
      SoundPlayerExtension soundPlayer = SoundPlayerExtension.instance();
      soundPlayer.setAsset(onScanBarcodeSound);
      _instance!.addExtension(soundPlayer);
    }

    bool vibrate = state.vibrateOnScanSetting.enabled;
    if(vibrate){
      _instance!.addExtension(VibratorExtension.instance());
    }

    _instance!.addExtension(ToasterExtension.instance());

  }

  final List<BarcodeSubscriber> _subscribers = [];
  final List<BarcodeCenterExtension> _extensions = [];

  @override
  Future<void> emitBarcode(String barcode) async {
    for(BarcodeCenterExtension bExtension in _extensions){
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


}