import 'package:equatable/equatable.dart';

class ChatContact extends Equatable{
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
 const ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });
  @override
  List<Object> get props=>[name,profilePic,contactId,timeSent,lastMessage,];
}
