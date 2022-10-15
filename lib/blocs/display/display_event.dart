
abstract class DisplayEvent{}

class NavigateByIndex extends DisplayEvent{
  final int index;
  NavigateByIndex(this.index);
}