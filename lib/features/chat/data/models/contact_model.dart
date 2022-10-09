import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/contact.dart';

class ChatContactModel extends ChatContact{
  const ChatContactModel({
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
      'timeSent': Timestamp.fromDate(timeSent),
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
