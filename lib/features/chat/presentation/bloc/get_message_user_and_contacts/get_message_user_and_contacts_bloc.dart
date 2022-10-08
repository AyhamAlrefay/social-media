import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_chat_contacts_use_case.dart';
import '../../../domain/usecases/get_message_user_usecase.dart';

part 'get_message_user_and_contacts_event.dart';
part 'get_message_user_and_contacts_state.dart';

class GetMessageUserAndContactsBloc extends Bloc<GetMessageUserAndContactsEvent, GetMessageUserAndContactsState> {
  final GetMessageUserUseCase getMessageUserUseCase;
  final GetChatContactsUseCase getChatContactsUseCase;
  GetMessageUserAndContactsBloc({required this.getChatContactsUseCase, required this.getMessageUserUseCase}) : super(GetMessageUserInitial());

  @override
  Stream<GetMessageUserAndContactsState> mapEventToState(
    GetMessageUserAndContactsEvent event,
  ) async* {
    if (event is GetChatMessageUserEvent) {
      emit(GetMessageUserStateLoading());
      final userFailureOrUserData =
      await getMessageUserUseCase.call(receiverUserId:event.receiverUserId );
      userFailureOrUserData.fold(
              (l) => emit(GetMessageUserStateError(error: _mapFailureToMessage(l))),
              (r) => emit(GetMessageUserStateSuccess( messages: r)));
    }
    else if(event is GetContactsEvent){
      emit(GetContactsLoading());
      final failureOrContacts= getChatContactsUseCase.call();
      _eitherDoneMessageOrErrorState(failureOrContacts);
    }
  }
}
 GetMessageUserAndContactsState _eitherDoneMessageOrErrorState(
    Either<Failure, Stream<List<ChatContact>>> failureOrDoneMessage) {
  return failureOrDoneMessage.fold(
          (failure) => GetContactsError(error: _mapFailureToMessage(failure)),
          (r) => GetContactsSuccess(contacts: r));
}
String _mapFailureToMessage(failure) {
  switch (failure.runtimeType) {
    case ServerChatFailure:
      return SERVER_CHAT_FAILURE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
