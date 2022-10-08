import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/core/datasources/firebase_storage_datasources.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/features/auth/presentation/pages/otp_screen.dart';
import 'package:whatsapp/features/auth/presentation/pages/user_information_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/snak_bar.dart';
import '../models/user_model.dart';
import 'package:whatsapp/injection_container.dart'as di;
abstract class AuthRemoteDataSources {
  Future<Unit> signInWithPhone(
      {required BuildContext context, required String phoneNumber});

  Future<Unit> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP});

  Future<Unit> saveUserData({required String name, required File profilePic});
  Future<UserModel>getCurrentUserData({required String userId});
}

class AuthRemoteDataSourcesImpl extends AuthRemoteDataSources {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourcesImpl({required this.auth, required this.firestore});

  @override
  Future<Unit> signInWithPhone(
      {required BuildContext context, required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showSnackBar(
              context: context,
              content: 'The provided phone number is not valid.');
        }
        throw ServerAuthException();
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.pushNamed(context, OtpScreen.routeName,
            arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);

      return Future.value(unit);
    } on FirebaseAuthException catch (e) {
      throw ServerAuthException();
    }
  }

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
      groupId: [],
    );
    await firestore.collection('users').doc(uid).set(user.toMap());
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCurrentUserData({required String userId}) async{
    try{
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(userId).get();
      final userModel =
          UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      print(userModel);
      return Future.value(userModel);
    }catch(e){
      throw ServerAuthException();
    }
  }
}
