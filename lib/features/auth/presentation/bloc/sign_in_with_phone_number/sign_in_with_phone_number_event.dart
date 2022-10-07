
part of 'sign_in_with_phone_number_bloc.dart';
abstract class SignInWithPhoneNumberEvent extends Equatable{
  const SignInWithPhoneNumberEvent();
  @override
  List<Object>get props=>[];
}
class PhoneNumberEvent extends SignInWithPhoneNumberEvent{
  final BuildContext context;
  final String phoneNumber;

  const PhoneNumberEvent({required this.context,required this.phoneNumber});
  @override
  List<Object>get props=>[context,phoneNumber];
}
class VerifyOtpEvent extends SignInWithPhoneNumberEvent{
  final BuildContext context;
  final String userOTP;
  final String verificationId;

  const VerifyOtpEvent({required this.context,required  this.userOTP,required this.verificationId});

}