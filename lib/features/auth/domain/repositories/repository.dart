import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/error/failures.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository{
  Future<Either<Failure ,Unit>>signInWithPhoneNumber({required BuildContext context,required String phoneNumber});
  Future<Either<Failure,Unit>>verifyOTP({required BuildContext context,required String verificationId,required String userOTP});
  Future<Either<Failure,Unit>>saveUserData({required String name,required File profilePic});
  Future<Either<Failure,UserEntity>>getCurrentUserData({required String userId});
}