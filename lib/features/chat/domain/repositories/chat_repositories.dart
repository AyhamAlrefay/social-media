import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entities/contact.dart';

abstract class ChatRepositories {
  Future<Either<Failure, Stream<List<Message>>>> getMessageUser(
      {required String receiverUserId});

  Future<Either<Failure, Unit>> sendMessage(
      {required Message message,
      required UserEntity senderUser,
      required UserEntity receiverUser});
 Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>>getChatContacts();
}
