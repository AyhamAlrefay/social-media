import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/datasources/firebase_storage_datasources.dart';
import '../../../../core/error/exceptions.dart';
import '../models/contact_model.dart';
import '../models/message_model.dart';
import '../../../auth/data/models/user_model.dart';
import 'dart:io';
abstract class ChatRemoteDataSources {
  Stream<QuerySnapshot<Map<String, dynamic>>>getChatContacts();
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageUser(
      {required String receiverUserId});
  Future<Unit> sendTextMessage({required MessageModel messageModel,
    required UserModel senderUserModel,
    required UserModel receiverUserModel});
  Future<Unit>sendImageMessage({required  MessageModel messageModel,required UserModel receiverUserModel,required senderUserModel});


}

class ChatRemoteDataSourcesImpl implements ChatRemoteDataSources {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorageDataSources firebaseStorageDataSources;

  ChatRemoteDataSourcesImpl({required this.firebaseStorageDataSources, required this.auth, required this.firestore});

  @override
  Stream<QuerySnapshot<Map<String,dynamic>>>  getMessageUser(
      {required String receiverUserId}) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots();
  }

  @override
  Future<Unit> sendTextMessage(
      {required MessageModel messageModel,
      required UserModel senderUserModel,
      required UserModel receiverUserModel}) {
    try {
      _saveDataToContactsSubcollection(
        senderUserModel: senderUserModel,
        receiverUserModel: receiverUserModel,
        message: messageModel.messageContent,
        timeSent: messageModel.timeSent,
        receiverId: messageModel.receiverId,
      );
      saveMessage(messageModel: messageModel);
      return Future.value(unit);
    } catch (e) {
      throw ServerChatException();
    }
  }

  void _saveDataToContactsSubcollection(
      {required UserModel senderUserModel,
      required UserModel receiverUserModel,
      required String message,
      required DateTime timeSent,
      required String receiverId}) async {
    ChatContactModel receiverChatContactModel = ChatContactModel(
        name: senderUserModel.name,
        profilePic: senderUserModel.profilePic,
        timeSent: timeSent,
        lastMessage: message,
        contactId: senderUserModel.uid);
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverChatContactModel.toMap());
    ChatContactModel senderChatContactModel = ChatContactModel(
        name: receiverUserModel.name,
        profilePic: receiverUserModel.profilePic,
        timeSent: timeSent,
        lastMessage: message,
        contactId: receiverUserModel.uid);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderChatContactModel.toMap());
  }

  void saveMessage({required MessageModel messageModel,String? imageUrl}) async {
    if(imageUrl==null) {
      await firestore
        .collection('users')
        .doc(messageModel.receiverId)
        .collection('chats')
        .doc(messageModel.senderId)
        .collection('messages')
        .doc(messageModel.messageId)
        .set(messageModel.toMap());
      await firestore
          .collection('users')
          .doc(messageModel.senderId)
          .collection('chats')
          .doc(messageModel.receiverId)
          .collection('messages')
          .doc(messageModel.messageId)
          .set(messageModel.toMap());
    }
    else{
      messageModel.messageContent=imageUrl;
      await firestore
          .collection('users')
          .doc(messageModel.receiverId)
          .collection('chats')
          .doc(messageModel.senderId)
          .collection('messages')
          .doc(messageModel.messageId)
          .set(messageModel.toMap());
      await firestore
          .collection('users')
          .doc(messageModel.senderId)
          .collection('chats')
          .doc(messageModel.receiverId)
          .collection('messages')
          .doc(messageModel.messageId)
          .set(messageModel.toMap());
    }

  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatContacts() {
  return  firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('chats')  
      .snapshots();
  }

  @override
  Future<Unit> sendImageMessage({required MessageModel messageModel, required UserModel receiverUserModel, required senderUserModel})async {
    try{
      var messageId = const Uuid().v1();
      String imageUrl = await firebaseStorageDataSources.storeFileToFirebase(
          'chat/${messageModel.type}/${senderUserModel.uid}/${receiverUserModel.uid}/$messageId',
          File(messageModel.messageContent.path));
      _saveDataToContactsSubcollection(
          senderUserModel: senderUserModel,
          receiverUserModel: receiverUserModel,
          message: imageUrl,
          timeSent: messageModel.timeSent,
          receiverId: messageModel.receiverId);
      saveMessage(messageModel: messageModel,imageUrl: imageUrl);
      return Future.value(unit);
    }catch(e){
      throw Exception();
    }
  }
}
