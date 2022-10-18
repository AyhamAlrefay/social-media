import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'managing_state_variables_in_chat_screen_event.dart';

part 'managing_state_variables_in_chat_screen_state.dart';

class ManagingStateVariablesInChatScreenBloc extends Bloc<
    ManagingStateVariablesInChatScreenEvent,
    ManagingStateVariablesInChatScreenState> {
  bool showKeyboardEmoji = false;
  bool showSendButton = false;

  ManagingStateVariablesInChatScreenBloc() : super(ShowKeyboardEmojiInitial()) {
    on<ManagingStateVariablesInChatScreenEvent>((event, state) async {
      if (event is ShowKeyboardEmojiEvent) {
        showKeyboardEmoji = true;
        emit(ShowKeyboardEmojiState(isShowEmojiKeyboard: showKeyboardEmoji));
      } else if (event is NotShowKeyboardEmojiEvent) {
        showKeyboardEmoji = false;
        emit(NotShowKeyboardEmoji(isShowEmojiKeyboard: showKeyboardEmoji));
      }
      if (event is ShowSendButtonEvent) {
        showSendButton = true;
        emit(ShowSendButtonState(showSendButton: showSendButton));
      } else if (event is NotShowSendButtonEvent) {
        showSendButton = false;
        emit(NotShowSendButtonState(notShowSendButton: showSendButton));
      }
    });
  }
}
