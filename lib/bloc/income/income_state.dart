part of 'income_bloc.dart';

class IncomeState extends Equatable {
  const IncomeState(this.isLoading, this.isCompleted, this.isFailed, this.date,
      this.amount, this.title);
  final bool isLoading;
  final bool isCompleted;
  final bool isFailed;
  final DateTime date;
  final double? amount;
  final String? title;

  @override
  List<Object?> get props =>
      [isLoading, isCompleted, isFailed, date, amount, title];

  IncomeState copyWith({
    bool? isLoading,
    bool? isCompleted,
    bool? isFailed,
    DateTime? date,
    double? amount,
    String? title,
  }) {
    return IncomeState(
      isLoading ?? this.isLoading,
      isCompleted ?? this.isCompleted,
      isFailed ?? this.isFailed,
      date ?? this.date,
      amount ?? this.amount,
      title ?? this.title,
    );
  }
}

class IncomeInitial extends IncomeState {
  IncomeInitial(super.isLoading, super.isCompleted, super.isFailed, super.date,
      super.amount, super.title);
}
