import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';

abstract class SoundPlayer {
  Future<void> playSound();
}

class DefaulSoundPlayer implements SoundPlayer, BarcodeCenterExtension {
  String soundPath;
  late AssetsAudioPlayer _assetsAudioPlayer ;

  DefaulSoundPlayer(this.soundPath){
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.open(Audio(soundPath));
  }
  
  @override
  Future<void> playSound() async {
    _assetsAudioPlayer.play();
  }
  
  @override
  void onBarcode(String barcode) {
    playSound();
  }
}