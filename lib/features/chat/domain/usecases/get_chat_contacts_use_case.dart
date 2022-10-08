import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failures.dart';

import '../entities/contact.dart';
import '../repositories/chat_repositories.dart';

class GetChatContactsUseCase{
  final ChatRepositories chatRepositories;

  GetChatContactsUseCase({required this.chatRepositories});
  Either<Failure,Stream<List<ChatContact>>> call(){
    return  chatRepositories.getChatContacts();
  }
}