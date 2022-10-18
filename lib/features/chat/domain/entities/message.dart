import 'package:equatable/equatable.dart';
import '../../../../core/enums/enum_message.dart';

class Message extends Equatable {
  //
  final String? senderUserName;
  final String? receiverUserName;
  final String? repliedMessage;
  final String? repliedTo;
  final MessageEnum? repliedMessageType;

  //
  final String senderId;
  final String receiverId;
   dynamic messageContent;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

   Message({
    this.repliedTo,
    this.receiverUserName,
    this.senderUserName,
    this.repliedMessage,
    this.repliedMessageType,
    required this.senderId,
    required this.receiverId,
    required this.messageContent,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  @override
  List<Object?> get props => [
        senderUserName,
        receiverUserName,
        senderId,
        receiverId,
        messageContent,
        type,
        timeSent,
        messageId,
        isSeen,
        repliedMessageType,
        repliedMessage,
        repliedTo
      ];
}
