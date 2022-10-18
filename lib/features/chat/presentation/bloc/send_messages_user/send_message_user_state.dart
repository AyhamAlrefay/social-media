part of 'send_message_user_bloc.dart';

abstract class SendMessageUserState extends Equatable {
  const SendMessageUserState();
}

class SendMessageUserInitial extends SendMessageUserState {
  @override
  List<Object> get props => [];
}
class SendMessageUserLoading extends SendMessageUserState{
  @override
  List<Object?> get props => [];
}
class SendMessageUserSuccess extends SendMessageUserState{

  @override
  List<Object?> get props => [];
}
class SendMessageUserError extends SendMessageUserState{
   final String error;

   const SendMessageUserError({
    required this.error,
  });

  @override
  List<Object?> get props => [];

}