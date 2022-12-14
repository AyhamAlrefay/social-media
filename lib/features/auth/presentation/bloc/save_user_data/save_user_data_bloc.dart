import 'dart:io';
import 'package:bloc/bloc.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/string_public.dart';
import '../../../domain/usecases/save_user_data_use_case.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_current_user_data_use_case.dart';

part 'save_user_data_event.dart';

part 'save_user_data_state.dart';

class SaveUserDataBloc extends Bloc<SaveUserDataEvent, SaveUserDataState> {
  final SaveUserDataUseCase saveUserDataUseCase;
  final GetCurrentUserDataUseCase getCurrentUserDataUseCase;

  SaveUserDataBloc({
    required this.getCurrentUserDataUseCase,
    required this.saveUserDataUseCase,
  }) : super(SaveUserDataStateInitial()) {
    on<SaveUserDataEvent>((event, emit) async {

      if (event is SaveUserData) {
        emit(SaveUserDataStateLoading());
        final failureOrDoneMessage = await saveUserDataUseCase.call(
            name: event.name, profilePic: event.profilePic);
        failureOrDoneMessage.fold(
                (failure) => emit(SaveUserDataStateError(error: _mapFailureToMessage(failure))),
                (_) => emit(SaveUserDataStateSuccess()));
      }
    });
  }
}

String _mapFailureToMessage(failure) {
  switch (failure.runtimeType) {
    case ServerAuthFailure:
      return SERVER_AUTH_FAILURE;
    default:
      return FAILURE_ERROR;
  }
}
