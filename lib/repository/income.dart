import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/income/income_bloc.dart';
import '../constants/db_names.dart';
import '../models/income_model.dart';
import '../models/month_model.dart';

class IncomeFirestore {
  Future<void> addIncomeToFirestore({
    required IncomeModel model,
    required DocumentReference reference,
    required Emitter<IncomeState> emit,
    required IncomeState state,
  }) async {
    double total = 0;
    double insideTotal = 0;
    //adding the data to db
    print(
        "-------------------------------------${model.date.year}${model.date.month}");
    await reference
        .collection(incomeCollection)
        .doc("${model.date.year}${model.date.month}")
        .set(DateModel(date: model.date).toMap());
    await reference
        .collection(incomeCollection)
        .doc("${model.date.year}${model.date.month}")
        .collection(incomeCollection)
        .add(model.toMap());

    try {
      DocumentSnapshot snapshot = await reference.parent.parent!.get();
      if (snapshot.exists) {
        total = snapshot["income"];
      }
      DocumentSnapshot insideSnapshot = await reference.get();
      if (insideSnapshot.exists) {
        insideTotal = insideSnapshot["income"];
      }
    } catch (e) {}
    // print(reference);
    //asigning total amount
    await reference.update({"income": model.amount + insideTotal});
    await reference.parent.parent!.update({"income": model.amount + total});
    emit(state.copyWith(isLoading: false, isCompleted: true));
  }

  Future<void> deleteIncomeFromFirestore(
      {DocumentReference? reference, required double amount}) async {
    //deleting file
    await reference!.delete();
    //deleteing from parent total
    var value = await reference.parent.parent!.parent.parent!.get();
    Map<String, dynamic> mapVal = value.data() as Map<String, dynamic>;
    await reference.parent.parent!.parent.parent!
        .update({"income": mapVal['income'] - amount});
//deliting from total
    var value2 =
        await reference.parent.parent!.parent.parent!.parent.parent!.get();
    Map<String, dynamic> mapVal2 = value2.data() as Map<String, dynamic>;
    await reference.parent.parent!.parent.parent!.parent.parent!
        .update({"income": mapVal2['income'] - amount});
  }
}
