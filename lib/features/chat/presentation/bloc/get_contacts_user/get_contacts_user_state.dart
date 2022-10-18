part of 'get_contacts_user_bloc.dart';

abstract class GetContactsUserState extends Equatable {
  const GetContactsUserState();
}

class GetContactsUserInitial extends GetContactsUserState {
  @override
  List<Object> get props => [];
}

class GetContactsUserLoading extends GetContactsUserState{
  @override
  List<Object?> get props => [];

}
class GetContactsUserError extends GetContactsUserState{
  final String error;

  const GetContactsUserError({required this.error});
  @override
  List<Object?> get props => [error];

}
class GetContactsUserSuccess extends GetContactsUserState{
  final Stream<QuerySnapshot<Map<String, dynamic>>>contacts;

  const GetContactsUserSuccess({
    required this.contacts,
  });

  @override
  List<Object?> get props => [contacts];

}

