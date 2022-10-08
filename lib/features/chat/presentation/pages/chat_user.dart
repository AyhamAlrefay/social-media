import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import '../widgets/chat_screen/chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';

  const ChatUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveUserDataBloc, SaveUserDataState>(
      builder: (context, state) {
        if (state is GetUserDataStateSuccess) {
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(state.user.profilePic),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),

                  Text(
                    state.user.name,
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
            ),
            body: Column(children: [
              Expanded(
                child: ChatList(receiverUserId: state.user.uid),
              ),
              BottomChatField(receiverUser: state.user,),
            ]),
          );
        }
        return Container();
      },);
  }
}
