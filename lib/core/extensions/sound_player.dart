import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';
import 'package:just_audio/just_audio.dart';

abstract class SoundPlayer {
  Future<void> playSound();
  Future<void> setAsset(String soundPath);
}

class SoundPlayerExtension implements SoundPlayer, BarcodeCenterExtension {
  late AudioPlayer audioPlayer;
  static SoundPlayerExtension? _instance;

  SoundPlayerExtension._() {
    audioPlayer = AudioPlayer();
  }

  factory SoundPlayerExtension.instance() {
    _instance ??= SoundPlayerExtension._();
    return _instance!;
  }

  @override
  Future<void> playSound() async {
    audioPlayer.play();
  }

  @override
  void onBarcode(String barcode) {
    if (!audioPlayer.playing) {
      playSound();
    }
  }

  @override
  Future<void> setAsset(String soundPath) async {
    audioPlayer.setAsset(soundPath, preload: false);
  }
}
