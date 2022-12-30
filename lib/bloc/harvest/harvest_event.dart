part of 'harvest_bloc.dart';

abstract class HarvestEvent extends Equatable {
  const HarvestEvent();

  @override
  List<Object> get props => [];
}

class ChangeDate extends HarvestEvent {
  final DateTime date;

  const ChangeDate({required this.date});
}

class AddHarvest extends HarvestEvent {
  final double nos;
  final DocumentReference reference;
  

  const AddHarvest({required this.nos, required this.reference});
}


