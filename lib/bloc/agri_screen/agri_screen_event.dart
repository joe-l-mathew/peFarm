part of 'agri_screen_bloc.dart';

abstract class AgriScreenEvent extends Equatable {
  const AgriScreenEvent();

  @override
  List<Object> get props => [];
}

class AddReference extends AgriScreenEvent {
  final DocumentReference reference;

  const AddReference({required this.reference});
}

class AddBottomIndex extends AgriScreenEvent {
  final int bottomIndex;

  const AddBottomIndex({required this.bottomIndex});
}
