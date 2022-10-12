
abstract class ReducerExecutable<S>{
  dynamic reduce(S state, StoreAction action);
}

abstract class StoreAction{
  int get index ;
  /// Important : don't use this method, it's only for the reducer register
  void setIndex(int executableIndex);
}

typedef ReducerBuilder = ReducerExecutable Function(int index);

abstract class ReducersCombiner{
  void registerReducer(ReducerBuilder reducerBuilder);
  dynamic reduce<S>(S currentState , StoreAction action);
}