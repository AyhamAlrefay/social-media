import 'package:equatable/equatable.dart';

import '../../../../core/enums/enum_message.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  @override
  List<Object?> get props => [
        senderId,
        receiverId,
        text,
        type,
        timeSent,
        messageId,
        isSeen,
        isSeen,
        repliedMessage,
        repliedTo,
        repliedMessageType,
      ];
}
