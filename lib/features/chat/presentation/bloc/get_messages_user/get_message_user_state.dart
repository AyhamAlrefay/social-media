part of 'get_message_user_bloc.dart';

abstract class GetMessageUserState extends Equatable {
  const GetMessageUserState();
}

class GetMessageUserInitial extends GetMessageUserState {
  @override
  List<Object?> get props =>[];
}
class GetMessageUserStateLoading extends GetMessageUserState{
  @override
  List<Object?> get props =>[];
}
class GetMessageUserStateError extends GetMessageUserState{
  final String error;
  const GetMessageUserStateError({required this.error});
  @override
  List<Object?> get props =>[error];
}
class GetMessageUserStateSuccess extends GetMessageUserState{
  final Stream<QuerySnapshot<Map<String, dynamic>>>  messages;
  const GetMessageUserStateSuccess({required this.messages});
  @override

  List<Object?> get props =>[messages];
}

