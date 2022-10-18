part of 'send_message_user_bloc.dart';

abstract class SendMessageUserEvent extends Equatable {
  const SendMessageUserEvent();
}
class SendMessageUser extends SendMessageUserEvent{
  final Message message;
  final UserEntity senderUser;
  final UserEntity receiverUser;

  SendMessageUser({
    required this.message,
   required this.senderUser,
    required this.receiverUser,
  });

  @override
  List<Object?> get props => [message,senderUser,receiverUser];
}