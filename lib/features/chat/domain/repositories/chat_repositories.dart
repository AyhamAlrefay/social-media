import 'package:dartz/dartz.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';

import '../../../../core/error/failures.dart';


abstract class ChatRepositories{
  Future<Either<Failure,Stream<List<Message>>>>getMessageUser({required String receiverUserId});
}