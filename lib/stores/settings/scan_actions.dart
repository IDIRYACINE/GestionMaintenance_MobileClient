
import 'package:gestion_maintenance_mobile/stores/types.dart';

class ToggleSoundAction extends StoreAction{
  static int? _index;
  @override
  int get index => _index?? -1;

  @override
  void setIndex(int executableIndex) {
    _index ??= executableIndex;
  }
  
}

class ToggleVibrationAction extends StoreAction{
 static int? _index;
  @override
  int get index => _index?? -1;

  @override
  void setIndex(int executableIndex) {
    _index ??= executableIndex;
  }
}

class ToggleContinousScanAction extends StoreAction{
  static int? _index;
  @override
  int get index => _index?? -1;

  @override
  void setIndex(int executableIndex) {
    _index ??= executableIndex;
  }
}