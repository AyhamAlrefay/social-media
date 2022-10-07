import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/chat/data/datasourses/remote_data_sources.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepositoriesImpl extends ChatRepositories{
  final ChatRemoteDataSources chatRemoteDataSources;

  ChatRepositoriesImpl({required this.chatRemoteDataSources});
  @override
  Future<Either<Failure, Stream<List<Message>>>> getMessageUser({required String receiverUserId}) async{
    try {
      final chatMessage =
          await chatRemoteDataSources.getMessageUser(receiverUserId: receiverUserId);
      return Right(chatMessage);
    } on ServerChatFailure {
      return Left(ServerChatFailure());
    }
    throw UnimplementedError();
  }

}