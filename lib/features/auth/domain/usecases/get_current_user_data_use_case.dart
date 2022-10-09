import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/repository.dart';

import '../../../../core/error/failures.dart';

class GetCurrentUserDataUseCase{
  final AuthRepository authRepository;

  GetCurrentUserDataUseCase({required this.authRepository});
  Future<Either<Failure, UserEntity>>call()async{
    return await authRepository.getCurrentUserData();
  }
}