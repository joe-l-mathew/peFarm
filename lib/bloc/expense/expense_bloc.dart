import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/expense_model.dart';
import '../../repository/expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc()
      : super(ExpenseInitial(false, false, false, DateTime.now(), null, null)) {
    on<UpdateDate>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(date: event.date));
    });

    on<AddExpense>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(isLoading: true));
      await ExpenseFirestore().addExpenseToFirestore(
          model: event.model,
          reference: event.reference,
          emit: emit,
          state: state);
    });
    on<DeleteExpense>((event, emit) async {
      // TODO: implement event handler
      await ExpenseFirestore().deleteExpenseFromFirestore(
          amount: event.amount, reference: event.reference);
      print(event.amount);
      print(event.reference);
    });
  }
}
