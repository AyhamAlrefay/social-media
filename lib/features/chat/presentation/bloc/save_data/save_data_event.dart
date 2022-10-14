part of 'save_data_bloc.dart';

abstract class SaveDataEvent extends Equatable {
  const SaveDataEvent();
}
class ChangeMessageReplyToDataEvent extends SaveDataEvent{
  MessageReply? messageReply;
  ChangeMessageReplyToDataEvent(this.messageReply);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ChangeMessageReplyToNullEvent extends SaveDataEvent{
  MessageReply? messageReply;
  ChangeMessageReplyToNullEvent(this.messageReply);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
