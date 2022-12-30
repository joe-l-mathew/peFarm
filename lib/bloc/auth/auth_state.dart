part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? phoneNumber;
  final String? verificationId;
  final PhoneAuthCredential? phoneAuthCredential;
  final String? otp;
  final bool isFailed;
  final bool isLoading;
  final bool isLoginCompleted;
  final UserCredential? credential;
  const AuthState(
      this.phoneNumber,
      this.verificationId,
      this.phoneAuthCredential,
      this.otp,
      this.isFailed,
      this.isLoading,
      this.isLoginCompleted,
      this.credential);

  @override
  List<Object?> get props => [
        phoneNumber,
        verificationId,
        phoneAuthCredential,
        otp,
        isFailed,
        isLoading,
        isLoginCompleted,
        credential
      ];

  AuthState copyWith({
    String? phoneNumber,
    String? verificationId,
    PhoneAuthCredential? phoneAuthCredential,
    String? otp,
    bool? isFailed,
    bool? isLoading,
    bool? isLoginCompleted,
    UserCredential? credential,
  }) {
    return AuthState(
      phoneNumber ?? this.phoneNumber,
      verificationId ?? this.verificationId,
      phoneAuthCredential ?? this.phoneAuthCredential,
      otp ?? this.otp,
      isFailed ?? this.isFailed,
      isLoading ?? this.isLoading,
      isLoginCompleted ?? this.isLoginCompleted,
      credential ?? this.credential,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial(
      super.phoneNumber,
      super.verificationId,
      super.phoneAuthCredential,
      super.otp,
      super.isFailed,
      super.isLoading,
      super.isLoginCompleted,
      super.credential);
}
