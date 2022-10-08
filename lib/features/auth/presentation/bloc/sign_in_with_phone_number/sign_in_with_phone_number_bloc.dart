import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/core/strings/messages.dart';
import 'package:whatsapp/features/auth/domain/usecases/sign_in_with_phone_number_use_case.dart';
import 'package:whatsapp/features/auth/domain/usecases/verify_otp_use_case.dart';
import '../../../../../core/strings/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'sign_in_with_phone_number_event.dart';
part 'sign_in_with_phone_number_state.dart';
class SignInWithPhoneNumberBloc extends Bloc<SignInWithPhoneNumberEvent,SignInWithPhoneNumberState>{
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  SignInWithPhoneNumberBloc({required this.verifyOtpUseCase,required this.signInWithPhoneNumberUseCase}):super(SignInWithPhoneNumberStateInitial()){
    on<SignInWithPhoneNumberEvent>((event,emit)async{
      if(event is PhoneNumberEvent)
        {
          emit(LoadingSignInWithPhoneNumberState());
          final failureOrDoneMessage=await signInWithPhoneNumberUseCase(context: event.context,phoneNumber: event.phoneNumber);
          emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,SIGN_IN_WITH_PHONE_NUMBER_SUCCESS));
        }
      else if(event is VerifyOtpEvent)
        {
          emit(LoadingVerifyOtp());
                final failureOrDoneMessage=await verifyOtpUseCase.call(context: event.context, userOTP: event.userOTP, verificationId: event.verificationId);
              emit(SuccessVerifyOtp());
        }
    });
  }
}
SignInWithPhoneNumberState _eitherDoneMessageOrErrorState(Either<Failure,Unit> either,String message){
  return either.fold(
      (failure)=>ErrorSignInWithPhoneNumberState(error:_mapFailureToMessage(failure),),
      (_)=>SuccessSignInWithPhoneNumberState(message: message),
  );
}
String _mapFailureToMessage(Failure failure){
  switch(failure.runtimeType){
    case ServerAuthFailure:
      return SERVER_AUTH_FAILURE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}