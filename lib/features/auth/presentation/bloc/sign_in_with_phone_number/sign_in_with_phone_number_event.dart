
part of 'sign_in_with_phone_number_bloc.dart';
abstract class SignInWithPhoneNumberEvent extends Equatable{
  const SignInWithPhoneNumberEvent();
  @override
  List<Object>get props=>[];
}
class PhoneNumberEvent extends SignInWithPhoneNumberEvent{
  final String phoneNumber;

  const PhoneNumberEvent({required this.phoneNumber});
  @override
  List<Object>get props=>[phoneNumber];
}
class VerifyOtpEvent extends SignInWithPhoneNumberEvent{
  final String userOTP;

  const VerifyOtpEvent({required  this.userOTP});

}