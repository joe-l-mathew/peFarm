part of 'agri_bloc.dart';

abstract class AgriEvent extends Equatable {
  const AgriEvent();

  @override
  List<Object> get props => [];
}

class AddAgri extends AgriEvent {
  final String agriName;

  const AddAgri({required this.agriName});
}

class DeleteAgri extends AgriEvent {
  final DocumentReference reference;
  final double income;
  final double expense;

  const DeleteAgri({
    required this.reference,
    required this.income,
    required this.expense,
  });
}
