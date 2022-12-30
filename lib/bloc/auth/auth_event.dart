part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//call for initializing phone auth
class PhoneNumberLogin extends AuthEvent {
  final String phoneNumber;
  final BuildContext context;

  const PhoneNumberLogin({
    required this.phoneNumber,
    required this.context,
  });
}

// event after otp sent
class GetVerificationId extends AuthEvent {
  final String verifiactionId;

  const GetVerificationId({required this.verifiactionId});
}

//event for invalid phonenumber
class InvalidPhone extends AuthEvent {}

//event for submitting otp
class SubmitOtp extends AuthEvent {
  final String otp;

  const SubmitOtp(this.otp);
}
