import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';

class GetMessageUserUseCase{
  final ChatRepositories chatRepositories;

  GetMessageUserUseCase({required this.chatRepositories});
Future<Either<Failure,Stream<List<Message>>>> call({required String receiverUserId })async{
  return await chatRepositories.getMessageUser(receiverUserId: receiverUserId);
}
}