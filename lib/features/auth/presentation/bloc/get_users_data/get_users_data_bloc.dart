import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_all_users_data.dart';
import '../../../domain/usecases/get_current_user_data_use_case.dart';
import '../../../domain/usecases/get_other_user_data_usecase.dart';

part 'get_users_data_event.dart';

part 'get_users_data_state.dart';

class GetUsersDataBloc extends Bloc<GetUsersDataEvent, GetUsersDataState> {
  final GetCurrentUserDataUseCase getCurrentUserDataUseCase;
  final GetOtherUserDataUseCase getOtherUserDataUseCase;
  final GetAllUsersDataUseCase getAllUsersDataUseCase;

  GetUsersDataBloc({
    required this.getCurrentUserDataUseCase,
    required this.getOtherUserDataUseCase,
    required this.getAllUsersDataUseCase,
  }) : super(GetUsersDataInitial()) {
    on<GetUsersDataEvent>((event, emit) async {

      if (event is GetCurrentUserData) {
        final Either<Failure, UserEntity> currentUser =
            await getCurrentUserDataUseCase.call();
        currentUser.fold((l) => () {},
            (r) => emit(GetCurrentUserDataSuccess(currentUser: r)));
      }

      else if (event is GetOtherUsersData) {
        final Either<Failure, UserEntity> otherUser =
            await getOtherUserDataUseCase.call(
                receiverUserId: event.receiverUserId);
        otherUser.fold((l) => () {},
            (r) => emit(GetOtherUserDataSateSuccess(otherUser: r)));
      }

      else if (event is GetAllUsersData) {
        final Either<Failure, List<UserEntity>> listUsers =
            await getAllUsersDataUseCase.call();
        listUsers.fold((l) => () {}, (r) {emit(GetAllUsersDataSuccess(listUsers: r));});
      }
    });
  }
}
