part of 'agri_screen_bloc.dart';

class AgriScreenState extends Equatable {
  final DocumentReference? reference;
  final int pageIndex;

  const AgriScreenState(this.reference, this.pageIndex);

  @override
  List<Object?> get props => [reference, pageIndex];

  AgriScreenState copyWith({
    DocumentReference? reference,
    int? pageIndex,
  }) {
    return AgriScreenState(
      reference ?? this.reference,
      pageIndex ?? this.pageIndex,
    );
  }
}

class AgriScreenInitial extends AgriScreenState {
  AgriScreenInitial(super.reference, super.pageIndex);
}
