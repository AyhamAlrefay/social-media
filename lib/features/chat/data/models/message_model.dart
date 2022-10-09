import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/enum_message.dart';
import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    //
    super.senderUserName,
    super.receiverUserName,
    super.repliedMessage,
    super.repliedMessageType,
    super.repliedTo,
    //
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.type,
    required super.timeSent,
    required super.messageId,
    required super.isSeen,
  });

  Map<String, dynamic> toMap() {
    if (repliedMessage!=null) {
      return {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'type': type.type,
        'timeSent': Timestamp.fromDate(timeSent),
        'messageId': messageId,
        'isSeen': isSeen,
        'repliedMessage': repliedMessage,
        'repliedMessageType': repliedMessageType,
        'senderUserName': senderUserName,
        'receiverUserName': receiverUserName,
        'repliedTo': repliedTo,
      };
    } else {
      return {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'type': type.type,
        'timeSent': Timestamp.fromDate(timeSent),
        'messageId': messageId,
        'isSeen': isSeen,
      };
    }
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    if (map.keys.contains('repliedMessage')) {
      return MessageModel(
        senderId: map['senderId'] ?? '',
        receiverId: map['receiverId'] ?? '',
        text: map['text'] ?? '',
        type: (map['type'] as String).toEnum(),
        timeSent: DateTime.parse(map['timeSent'].toDate().toString()),
        messageId: map['messageId'] ?? '',
        isSeen: map['isSeen'] ?? false,
        repliedMessage: map['repliedMessage'] ?? '',
        repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
        senderUserName: map['senderUserName'],
        receiverUserName: map['receiverUserName'],
        repliedTo: map['repliedTo'],
      );
    } else {
      return MessageModel(
        senderId: map['senderId'] ?? '',
        receiverId: map['receiverId'] ?? '',
        text: map['text'] ?? '',
        type: (map['type'] as String).toEnum(),
        timeSent:  DateTime.parse(map['timeSent'].toDate().toString()),
        messageId: map['messageId'] ?? '',
        isSeen: map['isSeen'] ?? false,
      );
    }
  }
}
