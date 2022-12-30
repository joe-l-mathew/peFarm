import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../bloc/harvest/harvest_bloc.dart';
import '../constants/db_names.dart';
import '../models/harvest_model.dart';
import '../models/month_model.dart';

class HarvestFirestore {
  Future<void> addHarvestToFirestore(
      {required double nos,
      required DateTime date,
      required DocumentReference reference,
      required Emitter<HarvestState> emit,
      required HarvestState state}) async {
    emit(state.copyWith(isLoading: true));
    try {
      await reference
          .collection(harvestCollection)
          .doc("${date.year}${date.month}")
          .set(MonthModel(date: date, totalNos: 0).toMap());

      reference
          .collection(harvestCollection)
          .doc("${date.year}${date.month}")
          .collection(harvestCollection)
          .add(HarvestModel(nos: nos, date: date).toMap());
      emit(state.copyWith(isCompleted: true, isLoading: false));
    } catch (e) {
      print(e);
      emit(state.copyWith(isLoading: false, isFailed: true));
    }
  }
}
