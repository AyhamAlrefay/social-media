import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../repositories/repository.dart';

import '../../../../core/error/failures.dart';

class SignInWithPhoneNumberUseCase {
  final AuthRepository repository;

  SignInWithPhoneNumberUseCase({required this.repository});
  Future<Either<Failure,Unit>>call({ required String phoneNumber})async{
    return await repository.signInWithPhoneNumber( phoneNumber: phoneNumber);
  }
}