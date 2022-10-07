import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';

class VerifyOtpUseCase{
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});
  Future<Either<Failure,Unit>>call({required BuildContext context,required String userOTP,required String verificationId})async{
    return await authRepository.verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }
}