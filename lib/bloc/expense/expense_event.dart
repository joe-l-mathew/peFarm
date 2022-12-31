part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class AddExpense extends ExpenseEvent {
  final ExpenseModel model;
  final DocumentReference reference;

  const AddExpense({
    required this.model,
    required this.reference,
  });
}

class UpdateDate extends ExpenseEvent {
  final DateTime date;

  const UpdateDate({required this.date});
}

class DeleteExpense extends ExpenseEvent {
  final DocumentReference reference;
  final double amount;

  const DeleteExpense({
    required this.reference,
    required this.amount,
  });
}
