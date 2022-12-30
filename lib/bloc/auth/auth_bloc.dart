import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthInitial(null, null, null, null, false, false, false, null)) {
    //calling get otp function
    on<PhoneNumberLogin>((event, emit) async {
      emit(state.copyWith(isLoading: true, phoneNumber: event.phoneNumber));
      await AuthRepository().phoneNumberAuth(
        phoneNumber: event.phoneNumber,
        context: event.context,
      );
    });

    //on senting otp
    on<GetVerificationId>(
      (event, emit) {
        emit(state.copyWith(
            isLoading: false, verificationId: event.verifiactionId));
      },
    );

    //on submitting otp
    on<SubmitOtp>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await AuthRepository()
          .submitOtp(otp: event.otp, state: state, emit: emit);
      emit(state.copyWith(isLoading: false));
    });
    on<InvalidPhone>((event, emit) {
      emit(state.copyWith(isLoading: false));
    });
  }
}
