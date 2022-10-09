import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/repository.dart';

class SaveUserDataUseCase{
  final AuthRepository authRepository;

  SaveUserDataUseCase({required this.authRepository});
  Future<Either<Failure,Unit>> call({required String name,required File profilePic})async{
    return await authRepository.saveUserData(name: name, profilePic: profilePic);
  }
}