part of 'agri_bloc.dart';

class AgriState extends Equatable {
  const AgriState(
    this.agriName,
    this.isLoading,
    this.isCompleted,
  );
  final String? agriName;
  final bool isLoading;
  final bool isCompleted;

  @override
  List<Object?> get props => [agriName, isLoading, isCompleted];

  @override
  String toString() =>
      'AgriState(agriName: $agriName, isLoading: $isLoading, isCompleted: $isCompleted)';

  AgriState copyWith({
    String? agriName,
    bool? isLoading,
    bool? isCompleted,
  }) {
    return AgriState(
      agriName ?? this.agriName,
      isLoading ?? this.isLoading,
      isCompleted ?? this.isCompleted,
    );
  }
}

class AgriInitial extends AgriState {
  AgriInitial(super.agriName, super.isLoading, super.isCompleted);
}
