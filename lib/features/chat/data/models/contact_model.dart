import 'package:whatsapp/features/chat/domain/entities/contact.dart';

class ChatContactModel extends ChatContact{
  ChatContactModel({
    required super.name,
    required super.profilePic,
    required super.contactId,
    required super.timeSent,
    required super.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.parse(map['timeSent'].toDate().toString()),
      lastMessage: map['lastMessage'] ?? '',
    );
  }
}
