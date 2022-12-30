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
    emit(state.copyWith(isLoading: true, isCompleted: false, isFailed: false));
    double totalNos = 0;
    try {
      //geting month details
      DocumentSnapshot<Map<String, dynamic>> snapshot = await reference
          .collection(harvestCollection)
          .doc("${date.year}${date.month}")
          .get();

      if (snapshot.exists) {
        totalNos = snapshot['totalNos'];
      }
    } catch (e) {}

    //updating total
    DocumentSnapshot doc = await reference.get();

    await reference.update({"nos": doc['nos'] + nos});
//updating...
    await reference
        .collection(harvestCollection)
        .doc("${date.year}${date.month}")
        .set(MonthModel(date: date, totalNos: totalNos + nos).toMap());
//adding new model
    reference
        .collection(harvestCollection)
        .doc("${date.year}${date.month}")
        .collection(harvestCollection)
        .add(HarvestModel(nos: nos, date: date).toMap());
    emit(state.copyWith(isCompleted: true, isLoading: false));
  }

  Future<void> deleteHarvestFromDb({
    required DocumentReference ref,
    required double nos,
  }) async {
    ///delete data
    await FirebaseFirestore.instance.doc(ref.path).delete();

    ///get month total ref
    DocumentReference monthYearRef = ref.parent.parent!;
    //get total nos
    var monthYrGet =
        await FirebaseFirestore.instance.doc(monthYearRef.path).get();
    double initialMonthTotal = monthYrGet.data()!['totalNos'];

    ///update month total
    await monthYearRef.update({"totalNos": initialMonthTotal - nos});

    ///path for total
    DocumentReference totalRef = monthYearRef.parent.parent!;
    var totalGet = await FirebaseFirestore.instance.doc(totalRef.path).get();
    double initialTotal = totalGet.data()!['nos'];
    //updating total
    await totalRef.update({"nos": initialTotal - nos});
  }
}
