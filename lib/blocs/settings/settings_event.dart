import 'package:camera/camera.dart';

abstract class SettingsEvent{}

class ToggleContinousScan extends SettingsEvent{}
class ToggleVibrateOnScan extends SettingsEvent{}
class TogglePlaySound extends SettingsEvent{}

class SetCameraResolution extends SettingsEvent{
  final ResolutionPreset resolution;

  SetCameraResolution(this.resolution);
}