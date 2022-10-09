import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import '../widgets/chat_screen/chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';

  const ChatUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersDataBloc, GetUsersDataState>(
      builder: (context, state) {
        if (state is GetOtherUserDataSateSuccess) {
          return Scaffold(
            appBar: buildAppBar(state),
            body: buildBody(state),
          );
        }
        return const LoadingWidget();
      },);
  }

  Column buildBody(GetOtherUserDataSateSuccess state) {
    return Column(children: [
            Expanded(
              child: ChatList(receiverUserId: state.otherUser.uid),
            ),
            BottomChatField(receiverUser: state.otherUser,),
          ]);
  }

  AppBar buildAppBar(GetOtherUserDataSateSuccess state) {
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
                  backgroundImage: NetworkImage(state.otherUser.profilePic),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),

                Text(
                  state.otherUser.name,
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
