import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:whatsapp/core/error/failures.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';

import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/get_message_user_usecase.dart';

part 'get_message_user_event.dart';
part 'get_message_user_state.dart';

class GetMessageUserBloc extends Bloc<GetMessageUserEvent, GetMessageUserState> {
  final GetMessageUserUseCase getMessageUserUseCase;
  GetMessageUserBloc({required this.getMessageUserUseCase}) : super(GetMessageUserInitial()) {
    on<GetMessageUserEvent>((event, emit) async{
      if (event is GetChatMessageUserEvent) {
        emit(GetMessageUserStateLoading());
        final userFailureOrUserData =
            await getMessageUserUseCase.call(receiverUserId:event.receiverUserId );
        userFailureOrUserData.fold(
                (l) => emit(GetMessageUserStateError(error: _mapFailureToMessage(l))),
                (r) => emit(GetMessageUserStateSuccess(message: r)));
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
