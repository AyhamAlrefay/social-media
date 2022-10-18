part of 'save_data_bloc.dart';

abstract class SaveDataEvent extends Equatable {
  const SaveDataEvent();
}
class ChangeMessageReplyToDataEvent extends SaveDataEvent{
  MessageReply? messageReply;
  ChangeMessageReplyToDataEvent({required this.messageReply});
  @override
  List<Object?> get props => [];

}
class ChangeMessageReplyToNullEvent extends SaveDataEvent{
  MessageReply? messageReply;
  ChangeMessageReplyToNullEvent({required this.messageReply});
  @override
 List<Object?> get props => [];
}
