part of 'save_data_bloc.dart';

abstract class SaveDataState extends Equatable {
  const SaveDataState();
}

class SaveDataInitial extends SaveDataState {
  @override
  List<Object> get props => [];
}
class ChangeMessageRelyToData extends SaveDataState{
  final MessageReply messageReply;
  const ChangeMessageRelyToData({required this.messageReply});
  @override
  List<Object?> get props =>[];
}
class NotMessageReply extends SaveDataState{
  @override
  List<Object?> get props =>[];
}