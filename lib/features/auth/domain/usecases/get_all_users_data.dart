import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/repository.dart';
import '../../../../core/error/failures.dart';

class GetAllUsersDataUseCase{
  final AuthRepository authRepository;

  GetAllUsersDataUseCase({required this.authRepository});
  Future<Either<Failure, List<UserEntity>>>call()async{
    return await authRepository.getAllUsersData();
  }
}