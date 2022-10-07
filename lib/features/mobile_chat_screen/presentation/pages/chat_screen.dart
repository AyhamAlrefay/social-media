import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../core/theme/colors.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';
  final Contact? contactInformation;

  const ChatUser({Key? key, required this.contactInformation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.amberAccent,
        ),
        backgroundColor: backgroundColor,
        titleSpacing: -10,
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
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.local_phone_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Center(child: Text('}')),
    );
  }
}
