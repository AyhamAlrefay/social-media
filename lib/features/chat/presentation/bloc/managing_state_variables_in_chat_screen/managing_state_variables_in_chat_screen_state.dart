part of 'managing_state_variables_in_chat_screen_bloc.dart';

@immutable
abstract class ManagingStateVariablesInChatScreenState extends Equatable {}
class ShowKeyboardEmojiInitial extends ManagingStateVariablesInChatScreenState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class ShowKeyboardEmojiLoading extends ManagingStateVariablesInChatScreenState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class ShowKeyboardEmojiStateSuccess extends ManagingStateVariablesInChatScreenState{
  final bool isShowEmojiKeyboard;

  ShowKeyboardEmojiStateSuccess({
    required this.isShowEmojiKeyboard,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class NotShowKeyboardEmojiSuccess extends ManagingStateVariablesInChatScreenState{
  final bool isShowEmojiKeyboard;


  NotShowKeyboardEmojiSuccess ({required this.isShowEmojiKeyboard});

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}