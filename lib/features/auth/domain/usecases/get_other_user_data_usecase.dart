import 'package:dartz/dartz.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';

import '../../../../core/error/failures.dart';

class GetOtherUserDataUseCase{
  final AuthRepository authRepository;

  GetOtherUserDataUseCase({required this.authRepository});
  Future<Either<Failure, UserEntity>>call({required String receiverUserId})async{
    return await authRepository.getOtherUserData(receiverUserId: receiverUserId);
  }
}