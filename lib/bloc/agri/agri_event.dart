part of 'agri_bloc.dart';

abstract class AgriEvent extends Equatable {
  const AgriEvent();

  @override
  List<Object> get props => [];
}

class AddAgri extends AgriEvent {
  final String agriName;

  AddAgri({required this.agriName});
}

class DeleteAgri extends AgriEvent {
  final DocumentReference reference;

  DeleteAgri({required this.reference});
}
