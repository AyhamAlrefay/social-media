import 'package:flutter/material.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import '../widgets/chat_screen/chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';
  final UserEntity receiver;
 final  UserEntity sender;
  const ChatUser({super.key, required this.receiver, required this.sender});

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: buildAppBar(),
            body: buildBody(),
          );
  }

  Column buildBody() {
    return Column(children: [
            Expanded(
             child: ChatList(receiverUserId:receiver.uid),
            ),
            BottomChatField(receiverUser: receiver,senderUser: sender,),
          ]);
  }

  AppBar buildAppBar() {
    return AppBar(
            scrolledUnderElevation: 15,
            iconTheme: const IconThemeData(
              color: Colors.amberAccent,
            ),
            backgroundColor: backgroundColor,
            titleSpacing: -10,
            centerTitle: false,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(receiver.profilePic),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),

                Text(
                  receiver.name,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.local_phone_rounded)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_outlined)),
            ],
          );
  }
}
