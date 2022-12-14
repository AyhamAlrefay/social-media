part of 'get_message_user_bloc.dart';

abstract class GetMessageUserEvent extends Equatable {
  const GetMessageUserEvent();
}
class GetChatMessageUserEvent extends GetMessageUserEvent{
  final String receiverUserId;

 const GetChatMessageUserEvent({required this.receiverUserId});

  @override
  List<Object?> get props => [];
}
