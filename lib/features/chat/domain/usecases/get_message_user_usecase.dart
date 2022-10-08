import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';

class GetMessageUserUseCase{
  final ChatRepositories chatRepositories;

  GetMessageUserUseCase({required this.chatRepositories});
Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>> call({required String receiverUserId }){
  return  chatRepositories.getMessageUser(receiverUserId: receiverUserId);
}
}