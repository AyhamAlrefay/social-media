import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/remote_data_sources.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/repository.dart';

class AuthRepositoriesImpl extends AuthRepository {
  final AuthRemoteDataSources remoteDataSources;

  AuthRepositoriesImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, Unit>> signInWithPhoneNumber(
      { required String phoneNumber}) async {
    try {
      await remoteDataSources.signInWithPhone(phoneNumber: phoneNumber);
      return const Right(unit);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(
      {
      required String userOTP}) async {
    try {
      await remoteDataSources.verifyOTP( userOTP: userOTP);
      return const Right(unit);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUserData(
      {required String name, required File profilePic}) async {
    try {
      await remoteDataSources.saveUserData(name: name, profilePic: profilePic);
      return const Right(unit);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final userEntity =
          await remoteDataSources.getCurrentUserData();
      return Right(userEntity);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }


  @override
  Future<Either<Failure, UserEntity>> getOtherUserData({required String receiverUserId}) async {
    try {
      final userEntity =
      await remoteDataSources.getOtherUserData(receiverUserId:receiverUserId);
      return Right(userEntity);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersData()async {
    try {
      List<UserModel> listUser =
          await remoteDataSources.getAllUsersData();
      return Right(listUser);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }}
}
