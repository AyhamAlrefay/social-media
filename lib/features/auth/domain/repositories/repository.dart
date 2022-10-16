import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository{
  Future<Either<Failure ,Unit>>signInWithPhoneNumber({required String phoneNumber});
  Future<Either<Failure,Unit>>verifyOTP({required String userOTP});
  Future<Either<Failure,Unit>>saveUserData({required String name,required File profilePic});
  Future<Either<Failure,UserEntity>>getCurrentUserData();
  Future<Either<Failure,UserEntity>>getOtherUserData({required String receiverUserId});
  Future<Either<Failure,List<UserEntity>>>getAllUsersData();

}