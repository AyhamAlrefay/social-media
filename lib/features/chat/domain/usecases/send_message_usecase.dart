import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entities/message.dart';

class SendMessageUseCase {
  final ChatRepositories chatRepositories;

  SendMessageUseCase({required this.chatRepositories});

  Future<Either<Failure, Unit>> call({ required Message message,
    required UserEntity senderUser,
    required UserEntity receiverUser}) async {
    return await chatRepositories.sendMessage(message: message,
        senderUser: senderUser,
        receiverUser: receiverUser);
  }
}