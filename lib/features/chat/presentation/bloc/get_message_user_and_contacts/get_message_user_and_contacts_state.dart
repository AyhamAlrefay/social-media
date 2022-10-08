part of 'get_message_user_and_contacts_bloc.dart';

abstract class GetMessageUserAndContactsState extends Equatable {
  const GetMessageUserAndContactsState();
}

class GetMessageUserInitial extends GetMessageUserAndContactsState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class GetMessageUserStateLoading extends GetMessageUserAndContactsState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class GetMessageUserStateError extends GetMessageUserAndContactsState{
  final String error;
  const GetMessageUserStateError({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props =>[error];
}
class GetMessageUserStateSuccess extends GetMessageUserAndContactsState{
  final Stream<List<Message>> messages;
  const GetMessageUserStateSuccess({required this.messages});
  @override
  // TODO: implement props
  List<Object?> get props =>[messages];
}
class GetContactsLoading extends GetMessageUserAndContactsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class GetContactsError extends GetMessageUserAndContactsState{
  final String error;

  const GetContactsError({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class GetContactsSuccess extends GetMessageUserAndContactsState{
 final Stream<QuerySnapshot<Map<String, dynamic>>>contacts;

 const GetContactsSuccess({
    required this.contacts,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [contacts];

}