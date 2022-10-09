import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_chat_contacts_use_case.dart';
import '../../../domain/usecases/get_message_user_usecase.dart';

part 'get_message_user_event.dart';
part 'get_message_user_state.dart';

class GetMessageUserBloc extends Bloc<GetMessageUserEvent, GetMessageUserState> {
  final GetMessageUserUseCase getMessageUserUseCase;
  final GetChatContactsUseCase getChatContactsUseCase;
  GetMessageUserBloc({required this.getChatContactsUseCase, required this.getMessageUserUseCase}) : super(GetMessageUserInitial()) {
    on<GetMessageUserEvent>((event, state) async {
      if (event is GetChatMessageUserEvent) {
        emit(GetMessageUserStateLoading());
        final messageFailureOrUserData =
        await getMessageUserUseCase.call(receiverUserId: event.receiverUserId);
        messageFailureOrUserData.fold(
                (l) => emit(GetMessageUserStateError(error: _mapFailureToMessage(l))),
                (r) => emit(GetMessageUserStateSuccess(messages: r)));
      }
    });
  }
  }


String _mapFailureToMessage(failure) {
  switch (failure.runtimeType) {
    case ServerChatFailure:
      return SERVER_CHAT_FAILURE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
