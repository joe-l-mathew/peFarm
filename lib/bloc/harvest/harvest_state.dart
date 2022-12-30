part of 'harvest_bloc.dart';

class HarvestState extends Equatable {
  final double? nos;
  final DateTime date;
  final bool isLoading;
  final bool isCompleted;
  final String nosString;
  final bool isFailed;
  const HarvestState(this.nos, this.date, this.isLoading, this.isCompleted,
      this.nosString, this.isFailed);

  @override
  List<Object?> get props =>
      [nos, date, isLoading, isCompleted, nosString, isFailed];

  HarvestState copyWith({
    double? nos,
    DateTime? date,
    bool? isLoading,
    bool? isCompleted,
    String? nosString,
    bool? isFailed,
  }) {
    return HarvestState(
      nos ?? this.nos,
      date ?? this.date,
      isLoading ?? this.isLoading,
      isCompleted ?? this.isCompleted,
      nosString ?? this.nosString,
      isFailed ?? this.isFailed,
    );
  }
}

class HarvestInitial extends HarvestState {
  HarvestInitial(super.nos, super.date, super.isLoading, super.isCompleted,
      super.nosString, super.isFailed);
}
