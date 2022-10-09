import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../repositories/chat_repositories.dart';

class GetChatContactsUseCase{
  final ChatRepositories chatRepositories;

  GetChatContactsUseCase({required this.chatRepositories});
  Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>> call(){
    return  chatRepositories.getChatContacts();
  }
}