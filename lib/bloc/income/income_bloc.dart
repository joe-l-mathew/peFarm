import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/income_model.dart';
import '../../repository/income.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc()
      : super(IncomeInitial(false, false, false, DateTime.now(), null, null)) {
    on<UpdateDate>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(date: event.date));
    });

    on<AddIncome>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(isLoading: true));
      await IncomeFirestore().addIncomeToFirestore(
          model: event.model,
          reference: event.reference,
          emit: emit,
          state: state);
    });
    on<DeleteIncome>((event, emit) async {
      // TODO: implement event handler
      await IncomeFirestore().deleteIncomeFromFirestore(
          amount: event.amount, reference: event.reference);
      print(event.amount);
      print(event.reference);
    });
  }
}
