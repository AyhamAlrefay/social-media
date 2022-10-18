part of 'managing_state_variables_in_chat_screen_bloc.dart';

@immutable
abstract class ManagingStateVariablesInChatScreenEvent extends Equatable{}

class ShowKeyboardEmojiEvent extends ManagingStateVariablesInChatScreenEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NotShowKeyboardEmojiEvent extends ManagingStateVariablesInChatScreenEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class ShowSendButtonEvent extends ManagingStateVariablesInChatScreenEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class NotShowSendButtonEvent extends ManagingStateVariablesInChatScreenEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class ChangeMessageReplyToDataEvent extends ManagingStateVariablesInChatScreenEvent{
  final MessageReply messageReply;
  ChangeMessageReplyToDataEvent({required this.messageReply});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class DeleteMessageReplyEvent extends ManagingStateVariablesInChatScreenEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}