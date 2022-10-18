import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/string_public.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/send_message_usecase.dart';

part 'send_message_user_event.dart';

part 'send_message_user_state.dart';

class SendMessageUserBloc
    extends Bloc<SendMessageUserEvent, SendMessageUserState> {
  final SendMessageUseCase sendMessageUserUseCase;

  SendMessageUserBloc({required this.sendMessageUserUseCase})
      : super(SendMessageUserInitial()){
    on<SendMessageUserEvent>((event,state)async{
      if (event is SendMessageUser) {
        emit(SendMessageUserLoading());
        final Either<Failure, Unit> failureOrDone= await sendMessageUserUseCase.call(message: event.message,
            senderUser: event.senderUser,
            receiverUser: event.receiverUser);
        emit(_eitherDoneMessageOrErrorState(failureOrDone));

      }
    });
  }

SendMessageUserState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> failureOrDoneMessage) {
  return failureOrDoneMessage.fold(
          (failure) => SendMessageUserError(error: _mapFailureToMessage(failure)),
          (_) => SendMessageUserSuccess());
}

String _mapFailureToMessage(failure) {
  switch (failure.runtimeType) {
    case ServerAuthFailure:
      return SERVER_CHAT_FAILURE;
    default:
      return FAILURE_ERROR;
  }
}
}
