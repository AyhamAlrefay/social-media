import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';

import '../../../../core/theme/colors.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import 'chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';
  final String name;
  final String uid;
  final String profilePic;

  final Contact? contactInformation;

  const ChatUser(
      {Key? key,
      required this.contactInformation,
      required this.name,
      required this.uid,
      required this.profilePic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 15,
        iconTheme: const IconThemeData(
          color: Colors.amberAccent,
        ),
        backgroundColor: backgroundColor,
        titleSpacing: -10,
        centerTitle: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
              radius: 25,
            ),
            const SizedBox(
              width: 15,
            ),

            Text(
              contactInformation!.name.first + contactInformation!.name.last,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.local_phone_rounded)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            child:ChatList(receiverUserId:uid),
          ),
        ),
        BottomChatField(),
      ]),
    );
  }
}
