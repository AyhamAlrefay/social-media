import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/string_public.dart';
import '../../../domain/usecases/get_chat_contacts_use_case.dart';

part 'get_contacts_user_event.dart';
part 'get_contacts_user_state.dart';

class GetContactsUserBloc extends Bloc<GetContactsUserEvent, GetContactsUserState> {
 final GetChatContactsUseCase getChatContactsUseCase;
  GetContactsUserBloc({required this.getChatContactsUseCase}) : super(GetContactsUserInitial()) {
    on<GetContactsUserEvent>((event, emit) {
      if (event is GetContactsUser) {
        emit(GetContactsUserLoading());
        final failureOrContacts = getChatContactsUseCase.call();
        failureOrContacts.fold((l) => emit( GetContactsUserError(error: _mapFailureToMessage(l))),
                (r) =>emit( GetContactsUserSuccess(contacts: r)));
      }
    });
  }
 String _mapFailureToMessage(failure) {
   switch (failure.runtimeType) {
     case ServerChatFailure:
       return SERVER_CHAT_FAILURE;
     default:
       return FAILURE_ERROR;
   }
}
}
