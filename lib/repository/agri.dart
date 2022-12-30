import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bloc/agri/agri_bloc.dart';
import '../constants/db_names.dart';
import '../models/agri_model.dart';

class FirestoreAgri {
  //adding new agri to firestore
  Future<void> addAgriToFirestore(
      {required AgriModel model,
      required Emitter<AgriState> emit,
      required AgriState state}) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(agriCollection)
        .add(model.toMap())
        .then((value) {
      emit(
        state.copyWith(isCompleted: true, isLoading: false),
      );
      emit(
        state.copyWith(isCompleted: false, isLoading: false),
      );
    });
  }
}
