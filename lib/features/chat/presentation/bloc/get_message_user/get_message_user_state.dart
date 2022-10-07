part of 'get_message_user_bloc.dart';

abstract class GetMessageUserState {
  const GetMessageUserState();
}

class GetMessageUserInitial extends GetMessageUserState {}
class GetMessageUserStateLoading extends GetMessageUserState{}
class GetMessageUserStateError extends GetMessageUserState{
  final String error;
  GetMessageUserStateError({required this.error});
}
class GetMessageUserStateSuccess extends GetMessageUserState{
  final Stream<List<Message>> message;
  GetMessageUserStateSuccess({required this.message});
}