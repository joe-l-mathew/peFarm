import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../constants/db_names.dart';
import '../functions/show_snackbar.dart';
import '../models/user_model.dart';

class AuthRepository {
  // funnction for phone auth
  Future<void> phoneNumberAuth({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        //what if verification is completed
        // await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // what if verification gets failed
        if (e.code == 'invalid-phone-number') {
          showSnackbar(context, "Invalid Phone Number");
          context.read<AuthBloc>().add(InvalidPhone());
        }
        showSnackbar(context, e.code);
        context.read<AuthBloc>().add(InvalidPhone());
      },
      codeSent: (String verificationId, int? resendToken) {
        context
            .read<AuthBloc>()
            .add(GetVerificationId(verifiactionId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> submitOtp(
      {required String otp,
      required AuthState state,
      required Emitter<AuthState> emit}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        final user = userCredential.user;
        final UserModel model =
            UserModel(phoneNumber: user!.phoneNumber!, uid: user.uid);
        firestore
            .collection(userCollection)
            .doc(userCredential.user!.uid)
            .set(model.toMap());
        emit(
            state.copyWith(credential: userCredential, isLoginCompleted: true));
      } else {
        emit(state.copyWith(isFailed: true));
      }
    } on Exception {
      emit(state.copyWith(isFailed: true));
      emit(state.copyWith(isFailed: false));
    }
  }
}
