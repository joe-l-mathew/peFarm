import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/agri_model.dart';
import '../../repository/agri.dart';

part 'agri_event.dart';
part 'agri_state.dart';

class AgriBloc extends Bloc<AgriEvent, AgriState> {
  AgriBloc() : super(AgriInitial(null, false, false)) {
    on<AddAgri>((event, emit) async {
      // TODO: implement event handler
      // start loading
      emit(state.copyWith(isLoading: true));
      //call repo to add agri
      AgriModel model = AgriModel(
          name: event.agriName, income: 0, expense: 0, date: DateTime.now());
      await FirestoreAgri()
          .addAgriToFirestore(model: model, emit: emit, state: state);
    });
  }
}