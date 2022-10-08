import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/auth/data/models/user_model.dart';
import 'package:whatsapp/features/chat/data/datasourses/remote_data_sources.dart';
import 'package:whatsapp/features/chat/data/models/message_model.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';

import '../../../auth/domain/entities/user_entity.dart';

class ChatRepositoriesImpl extends ChatRepositories {
  final ChatRemoteDataSources chatRemoteDataSources;

  ChatRepositoriesImpl({required this.chatRemoteDataSources});

  @override
  Future<Either<Failure, Stream<List<Message>>>> getMessageUser(
      {required String receiverUserId}) async {
    try {
      final chatMessage = await chatRemoteDataSources.getMessageUser(
          receiverUserId: receiverUserId);
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
          text: message.text,
          type: message.type,
          timeSent: message.timeSent,
          messageId: message.messageId,
          isSeen: message.isSeen);
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
      await chatRemoteDataSources.sendTextMessage(
          messageModel: messageModel,
          senderUserModel: senderUserModel,
          receiverUserModel: receiverUserModel);
      return const Right(unit);
    } on ServerChatException {
      return Left(ServerChatFailure());
    }
  }

  @override
  Either<Failure,Stream<List<ChatContact>>> getChatContacts(){
    try{
      return  Right(chatRemoteDataSources.getChatContacts());
    }on ServerChatException{
      return Left(ServerChatFailure());
    }

  }
}
