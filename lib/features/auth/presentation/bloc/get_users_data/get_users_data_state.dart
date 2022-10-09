part of 'get_users_data_bloc.dart';

abstract class GetUsersDataState extends Equatable {
  const GetUsersDataState();
}

class GetUsersDataInitial extends GetUsersDataState {
  @override
  List<Object> get props => [];
}
class GetCurrentUserDataSuccess extends GetUsersDataState{
  final UserEntity currentUser;

  const GetCurrentUserDataSuccess({required this.currentUser});
  @override
  List<Object?> get props => [currentUser];
}
class GetOtherUserDataSateSuccess extends GetUsersDataState{
  final UserEntity otherUser;

 const GetOtherUserDataSateSuccess({required this.otherUser});
  @override
  List<Object?> get props => [otherUser];
}