import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/datasources/firebase_storage_datasources.dart';
import '../../../../core/error/exceptions.dart';
import '../../presentation/bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import '../../presentation/pages/otp_screen.dart';
import '../../presentation/pages/user_information_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/snak_bar.dart';
import '../models/user_model.dart';
import '../../../../injection_container.dart'as di;
abstract class AuthRemoteDataSources {
  Future<Unit> signInWithPhone(
      { required String phoneNumber});

  Future<Unit> verifyOTP(
      {
      required String userOTP});

  Future<Unit> saveUserData({required String name, required File profilePic});
  Future<UserModel>getCurrentUserData();
  Future<UserModel>getOtherUserData({required String receiverUserId});
}

class AuthRemoteDataSourcesImpl extends AuthRemoteDataSources {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  String  _verificationId='';
  AuthRemoteDataSourcesImpl({required this.auth, required this.firestore});

  @override
  Future<Unit> signInWithPhone(
      {required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw ServerAuthException();
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId=verificationId;
        print('////////////////////////');
        print(_verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> verifyOTP({
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: userOTP);
      await auth.signInWithCredential(credential);

      return Future.value(unit);
    } on FirebaseAuthException catch (e) {
      throw ServerAuthException();
    }
  }

  @override
  Future<Unit> saveUserData(
      {required String name, required File profilePic}) async {
    String uid = auth.currentUser!.uid;
    String photoUrl =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
    if (profilePic != null) {
      photoUrl = await di.sl<FirebaseStorageDataSources>().storeFileToFirebase('profilePic/$uid', profilePic);
    }
    var user = UserModel(
      name: name,
      uid: uid,
      profilePic: photoUrl,
      isOnline: true,
      phoneNumber: auth.currentUser!.phoneNumber!,
      groupId: const [],
    );
    await firestore.collection('users').doc(uid).set(user.toMap());
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCurrentUserData() async{

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      final userModel =
          UserModel.fromMap(snapshot.data()!);

      return Future.value(userModel);
  }


  @override
  Future<UserModel> getOtherUserData({required String receiverUserId}) async{

      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection('users').doc(receiverUserId).get();
      final userModel =
      UserModel.fromMap(snapshot.data()!);

      return Future.value(userModel);

  }


}
