import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';
import '../models/contact_model.dart';
import '../models/message_model.dart';
import '../../../auth/data/models/user_model.dart';

abstract class ChatRemoteDataSources {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageUser(
      {required String receiverUserId});
  Future<Unit> sendTextMessage({required MessageModel messageModel,
    required UserModel senderUserModel,
    required UserModel receiverUserModel});
  Stream<QuerySnapshot<Map<String, dynamic>>>getChatContacts();
}

class ChatRemoteDataSourcesImpl implements ChatRemoteDataSources {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRemoteDataSourcesImpl({required this.auth, required this.firestore});

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
        message: messageModel.text,
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
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(senderChatContactModel.toMap());
  }

  void saveMessage({required MessageModel messageModel}) async {
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

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatContacts() {
  return  firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('chats')  
      .snapshots();
  }
}
