part of 'get_users_data_bloc.dart';

abstract class GetUsersDataEvent extends Equatable {
  const GetUsersDataEvent();
}

class GetCurrentUserData extends GetUsersDataEvent{
  @override
  List<Object?> get props => [];
}
class GetOtherUsersData extends GetUsersDataEvent{
  final String receiverUserId;
  const GetOtherUsersData({required this.receiverUserId});

  @override
  List<Object?> get props => [receiverUserId];
}

class GetAllUsersData extends GetUsersDataEvent{
  @override
  List<Object?> get props => [];
}