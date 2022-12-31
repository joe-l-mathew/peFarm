import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'agri_screen_event.dart';
part 'agri_screen_state.dart';

class AgriScreenBloc extends Bloc<AgriScreenEvent, AgriScreenState> {
  AgriScreenBloc() : super(const AgriScreenInitial(null, 0)) {
    on<AddReference>((event, emit) {
      // ignore: todo
      emit(state.copyWith(reference: event.reference));
    });

    on<AddBottomIndex>((event, emit) {
      // ignore: todo
      emit(state.copyWith(pageIndex: event.bottomIndex));
    });
  }
}
