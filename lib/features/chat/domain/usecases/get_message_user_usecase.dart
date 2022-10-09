import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/message.dart';
import '../repositories/chat_repositories.dart';

class GetMessageUserUseCase{
  final ChatRepositories chatRepositories;

  GetMessageUserUseCase({required this.chatRepositories});
Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>> call({required String receiverUserId }){
  return  chatRepositories.getMessageUser(receiverUserId: receiverUserId);
}
}