
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/models/user_model.dart';
import '../datasourses/remote_data_sources.dart';
import '../models/message_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repositories.dart';

import '../../../auth/domain/entities/user_entity.dart';

class ChatRepositoriesImpl extends ChatRepositories {
  final ChatRemoteDataSources chatRemoteDataSources;

  ChatRepositoriesImpl({required this.chatRemoteDataSources});

  @override
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>> getMessageUser(
      {required String receiverUserId}) {
    try {
      final chatMessage =
          chatRemoteDataSources.getMessageUser(receiverUserId: receiverUserId);
      return Right(chatMessage);
    } on ServerChatFailure {
      return Left(ServerChatFailure());
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      {required Message message,
      required UserEntity senderUser,
      required UserEntity receiverUser}) async {
    try {
      final messageModel = MessageModel(
        senderId: message.senderId,
        receiverId: message.receiverId,
        messageContent: message.messageContent,
        type: message.type,
        timeSent: message.timeSent,
        messageId: message.messageId,
        isSeen: message.isSeen,
        repliedTo: message.repliedTo,
        repliedMessageType: message.repliedMessageType,
        repliedMessage: message.repliedMessage,
        receiverUserName: message.receiverUserName,
        senderUserName: message.senderUserName,
      );
      final senderUserModel = UserModel(
          name: senderUser.name,
          uid: senderUser.uid,
          profilePic: senderUser.profilePic,
          isOnline: senderUser.isOnline,
          phoneNumber: senderUser.phoneNumber,
          groupId: senderUser.groupId);
      final receiverUserModel = UserModel(
          name: receiverUser.name,
          uid: receiverUser.uid,
          profilePic: receiverUser.profilePic,
          isOnline: receiverUser.isOnline,
          phoneNumber: receiverUser.phoneNumber,
          groupId: receiverUser.groupId);
      if(message.messageContent is String) {
        await chatRemoteDataSources.sendTextMessage(
          messageModel: messageModel,
          senderUserModel: senderUserModel,
          receiverUserModel: receiverUserModel);
      }
      else if(message.messageContent is XFile)
        {
          await chatRemoteDataSources.sendImageMessage(
              messageModel: messageModel,
              senderUserModel: senderUserModel,
              receiverUserModel: receiverUserModel);
        }

      return const Right(unit);
    } on ServerChatException {
      return Left(ServerChatFailure());
    }
  }

  @override
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>
      getChatContacts() {
    try {
      return Right(chatRemoteDataSources.getChatContacts());
    } on ServerChatException {
      return Left(ServerChatFailure());
    }
  }


}
