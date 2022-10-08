part of 'get_message_user_and_contacts_bloc.dart';

abstract class GetMessageUserAndContactsEvent extends Equatable {
  const GetMessageUserAndContactsEvent();
}
class GetChatMessageUserEvent extends GetMessageUserAndContactsEvent{
  final String receiverUserId;

 const GetChatMessageUserEvent({required this.receiverUserId});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetContactsEvent extends GetMessageUserAndContactsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}