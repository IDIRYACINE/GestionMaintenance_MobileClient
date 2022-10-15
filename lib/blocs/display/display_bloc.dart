
import 'package:bloc/bloc.dart';

import 'display_event.dart';
import 'display_state.dart';

class DisplayBloc extends Bloc<DisplayEvent,DisplayState>{
  DisplayBloc() : super(DisplayState.initialState()){
    on<NavigateByIndex>((_onNavigateByIndex) );
  }

  Future<void> _onNavigateByIndex(NavigateByIndex event,Emitter<DisplayState> emitter) async{
    emitter(state.copyWith(selectedIndex : event.index));
  }
}