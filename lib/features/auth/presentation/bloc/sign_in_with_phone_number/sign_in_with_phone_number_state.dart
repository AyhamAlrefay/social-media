part of 'sign_in_with_phone_number_bloc.dart';

abstract class SignInWithPhoneNumberState extends Equatable {
  const SignInWithPhoneNumberState();

  @override
  List<Object> get props => [];
}

class SignInWithPhoneNumberStateInitial extends SignInWithPhoneNumberState {}

class LoadingSignInWithPhoneNumberState extends SignInWithPhoneNumberState {}

class ErrorSignInWithPhoneNumberState extends SignInWithPhoneNumberState {
  final String error;
  const ErrorSignInWithPhoneNumberState({required this.error});
}

class SuccessSignInWithPhoneNumberState extends SignInWithPhoneNumberState {}

class VerifyOtpInitial extends SignInWithPhoneNumberState {}

class LoadingVerifyOtp extends SignInWithPhoneNumberState {}

class ErrorVerifyOtp extends SignInWithPhoneNumberState {
  final String message;
  const ErrorVerifyOtp({required this.message});
}

class SuccessVerifyOtp extends SignInWithPhoneNumberState {const SuccessVerifyOtp();}
