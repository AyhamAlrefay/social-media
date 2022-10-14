part of 'save_data_bloc.dart';

abstract class SaveDataState extends Equatable {
  const SaveDataState();
}

class SaveDataInitial extends SaveDataState {
  @override
  List<Object> get props => [];
}
class ChangeMessageRelyToData extends SaveDataState{
  MessageReply? messageReply;
  ChangeMessageRelyToData(this.messageReply);
  @override
  List<Object?> get props =>[];
}
class ChangeMessageReplyToNull extends SaveDataState{

  @override
  List<Object?> get props =>[];
}