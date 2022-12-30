import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../repository/harvest.dart';

part 'harvest_event.dart';
part 'harvest_state.dart';

class HarvestBloc extends Bloc<HarvestEvent, HarvestState> {
  HarvestBloc()
      : super(HarvestInitial(null, DateTime.now(), false, false, "", false)) {
    on<ChangeDate>((event, emit) {
      emit(state.copyWith(date: event.date));
    });
    on<AddHarvest>(
      (event, emit) async {
        emit(state.copyWith(isLoading: false, nos: event.nos));
        await HarvestFirestore().addHarvestToFirestore(
            nos: event.nos,
            date: state.date,
            reference: event.reference,
            emit: emit,
            state: state);
      },
    );
  }
}
