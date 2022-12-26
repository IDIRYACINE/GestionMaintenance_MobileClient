
abstract class AppEvent{}

class NavigateByIndex extends AppEvent{
  final int index;
  NavigateByIndex(this.index);
}

class ToggleScanState extends AppEvent{
  final bool scanState;
  ToggleScanState(this.scanState);
}