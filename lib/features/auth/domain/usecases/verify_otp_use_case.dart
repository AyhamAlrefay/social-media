import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/repository.dart';

class VerifyOtpUseCase{
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});
  Future<Either<Failure,Unit>>call({required String userOTP})async{
    return await authRepository.verifyOTP( userOTP: userOTP);
  }
}