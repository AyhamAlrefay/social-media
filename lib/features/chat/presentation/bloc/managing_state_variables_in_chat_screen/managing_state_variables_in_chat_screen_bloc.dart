
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'managing_state_variables_in_chat_screen_event.dart';
part 'managing_state_variables_in_chat_screen_state.dart';
class ManagingStateVariablesInChatScreenBloc extends Bloc<ManagingStateVariablesInChatScreenEvent,ManagingStateVariablesInChatScreenState>{
  bool showKeyboardEmoji=false;
  ManagingStateVariablesInChatScreenBloc():super(ShowKeyboardEmojiInitial()){
    on<ManagingStateVariablesInChatScreenEvent>((event, state)async {
      emit(ShowKeyboardEmojiLoading());
      if(event is ShowKeyboardEmojiEvent){
        showKeyboardEmoji=true;
        emit( ShowKeyboardEmojiStateSuccess(isShowEmojiKeyboard: showKeyboardEmoji));
      }else if(event is NotShowKeyboardEmojiEvent)
        {
          showKeyboardEmoji=false;
          emit(NotShowKeyboardEmojiSuccess(isShowEmojiKeyboard: showKeyboardEmoji));
        }
    });
  }

}
