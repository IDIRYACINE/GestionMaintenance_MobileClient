
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_events.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';

class RecordsBloc extends Bloc<RecordEvent,RecordState>{

  RecordsBloc(super.initialState){
    on<AddRecord>((_addRecord));
    on<LoadRecords>((_loadRecords));
    on<UpdateRecord>((_updateRecord));
  }


  Future<void> _addRecord(AddRecord event, Emitter<RecordState> emit) async {
    List<Record> records = List.from(state.records);
    records.add(event.record);
    emit(RecordState(records));
  }

  Future<void> _loadRecords(LoadRecords event, Emitter<RecordState> emit) async {
    emit(RecordState(event.records));
  }

  Future<void> _updateRecord(UpdateRecord event, Emitter<RecordState> emit) async {
    List<Record> records = List.from(state.records);
    records[event.index] = event.record;
    emit(RecordState(records));
  }


}