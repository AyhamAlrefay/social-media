import 'package:equatable/equatable.dart';

import '../../../../core/enums/enum_message.dart';

class MessageReply extends Equatable{
 final String message;
  final    bool isMe;
 final MessageEnum messageEnum;

  const MessageReply({required this.message,required this.isMe, required this.messageEnum});

  @override
  List<Object?> get props =>[message,messageEnum,isMe];
}