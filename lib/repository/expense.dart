import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense/expense_bloc.dart';
import '../constants/db_names.dart';
import '../models/expense_model.dart';
import '../models/month_model.dart';

class ExpenseFirestore {
  Future<void> addExpenseToFirestore({
    required ExpenseModel model,
    required DocumentReference reference,
    required Emitter<ExpenseState> emit,
    required ExpenseState state,
  }) async {
    double total = 0;
    double insideTotal = 0;
    //adding the data to db
    print(
        "-------------------------------------${model.date.year}${model.date.month}");
    await reference
        .collection(expenseCollection)
        .doc("${model.date.year}${model.date.month}")
        .set(DateModel(date: model.date).toMap());
    await reference
        .collection(expenseCollection)
        .doc("${model.date.year}${model.date.month}")
        .collection(expenseCollection)
        .add(model.toMap());

    try {
      DocumentSnapshot snapshot = await reference.parent.parent!.get();
      if (snapshot.exists) {
        total = snapshot["expense"];
      }
      DocumentSnapshot insideSnapshot = await reference.get();
      if (insideSnapshot.exists) {
        insideTotal = insideSnapshot["expense"];
      }
    } catch (e) {}
    // print(reference);
    //asigning total amount
    await reference.update({"expense": model.amount + insideTotal});
    await reference.parent.parent!.update({"expense": model.amount + total});
    emit(state.copyWith(isLoading: false, isCompleted: true));
  }

  Future<void> deleteExpenseFromFirestore(
      {DocumentReference? reference, required double amount}) async {
    //deleting file
    await reference!.delete();
    //deleteing from parent total
    var value = await reference.parent.parent!.parent.parent!.get();
    Map<String, dynamic> mapVal = value.data() as Map<String, dynamic>;
    await reference.parent.parent!.parent.parent!
        .update({"expense": mapVal['expense'] - amount});
//deliting from total
    var value2 =
        await reference.parent.parent!.parent.parent!.parent.parent!.get();
    Map<String, dynamic> mapVal2 = value2.data() as Map<String, dynamic>;
    await reference.parent.parent!.parent.parent!.parent.parent!
        .update({"expense": mapVal2['expense'] - amount});
  }
}
