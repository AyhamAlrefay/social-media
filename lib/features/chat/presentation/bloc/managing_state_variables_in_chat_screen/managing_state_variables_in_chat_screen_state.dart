part of 'managing_state_variables_in_chat_screen_bloc.dart';

@immutable
abstract class ManagingStateVariablesInChatScreenState extends Equatable {}
class ShowKeyboardEmojiInitial extends ManagingStateVariablesInChatScreenState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class ShowKeyboardEmojiState extends ManagingStateVariablesInChatScreenState{
  final bool isShowEmojiKeyboard;

  ShowKeyboardEmojiState({
    required this.isShowEmojiKeyboard,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class NotShowKeyboardEmojiState extends ManagingStateVariablesInChatScreenState{
  final bool isShowEmojiKeyboard;


  NotShowKeyboardEmojiState ({required this.isShowEmojiKeyboard});

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class ShowSendButtonState extends ManagingStateVariablesInChatScreenState{
  final bool showSendButton ;

  ShowSendButtonState({required this.showSendButton});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NotShowSendButtonState extends ManagingStateVariablesInChatScreenState{
  final bool notShowSendButton;

  NotShowSendButtonState({
   required  this.notShowSendButton,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [notShowSendButton];
}
class ChangeMessageRelyToDataState extends ManagingStateVariablesInChatScreenState{
  final MessageReply messageReply;

  ChangeMessageRelyToDataState({
   required this.messageReply,
  });

  @override
  List<Object?> get props =>[messageReply];
}
class NotMessageReplyState extends ManagingStateVariablesInChatScreenState{
  @override
  List<Object?> get props =>[];
}