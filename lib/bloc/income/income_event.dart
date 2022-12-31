part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class AddIncome extends IncomeEvent {
  final IncomeModel model;
  final DocumentReference reference;

  const AddIncome({
    required this.model,
    required this.reference,
  });
}

class UpdateDate extends IncomeEvent {
  final DateTime date;

  const UpdateDate({required this.date});
}

class DeleteIncome extends IncomeEvent {
  final DocumentReference reference;
  final double amount;

  const DeleteIncome({
    required this.reference,
    required this.amount,
  });
}
