part of 'get_message_user_bloc.dart';

abstract class GetMessageUserEvent {
  const GetMessageUserEvent();
}
class GetChatMessageUserEvent extends GetMessageUserEvent{
  final String receiverUserId;

  GetChatMessageUserEvent({required this.receiverUserId});
}