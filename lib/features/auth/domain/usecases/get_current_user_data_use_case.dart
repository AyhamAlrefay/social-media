import 'package:dartz/dartz.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';

import '../../../../core/error/failures.dart';

class GetCurrentUserDataUseCase{
  final AuthRepository authRepository;

  GetCurrentUserDataUseCase({required this.authRepository});
  Future<Either<Failure, User>>call()async{
    return await authRepository.getCurrentUserData();
  }
}