
import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class AppBloc extends Bloc<AppEvent,AppState>{
  AppBloc() : super(AppState.initialState()){
    on<NavigateByIndex>((_onNavigateByIndex) );
    on<ToggleScanState>((_onToggleScanState) );
  }

  Future<void> _onNavigateByIndex(NavigateByIndex event,Emitter<AppState> emitter) async{
    emitter(state.copyWith(selectedIndex : event.index));
  }

  Future<void> _onToggleScanState(ToggleScanState event,Emitter<AppState> emitter) async{
    emitter(state.copyWith(isScanning : event.scanState));
  }

}