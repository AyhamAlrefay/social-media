import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/auth/data/datasources/remote_data_sources.dart';
import 'package:whatsapp/features/auth/data/models/user_model.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';

class AuthRepositoriesImpl extends AuthRepository {
  final AuthRemoteDataSources remoteDataSources;

  AuthRepositoriesImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, Unit>> signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await remoteDataSources.signInWithPhone(
          context: context, phoneNumber: phoneNumber);
      return const Right(unit);
    } on ServerAuthException {
      return Left(ServerAuthFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      await remoteDataSources.verifyOTP(
          context: context, verificationId: verificationId, userOTP: userOTP);
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
}
