import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';

import '../../../../core/error/failures.dart';

class SignInWithPhoneNumberUseCase {
  final AuthRepository repository;

  SignInWithPhoneNumberUseCase({required this.repository});
  Future<Either<Failure,Unit>>call({required BuildContext context ,required String phoneNumber})async{
    return await repository.signInWithPhoneNumber(context: context, phoneNumber: phoneNumber);
  }
}