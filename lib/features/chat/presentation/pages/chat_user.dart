import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import '../widgets/chat_screen/chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';
   UserEntity ? receiver;
   UserEntity ? sender;
   ChatUser({super.key,  this.receiver,  this.sender});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUsersDataBloc, GetUsersDataState>(
      listener: (BuildContext context, state) {
        if (state is GetCurrentUserDataSuccess) {
          sender = state.currentUser;
        }
        if (state is GetOtherUserDataSateSuccess) {
          receiver = state.otherUser;
        }
      },
      builder: (BuildContext context, state) {
        if (receiver != null && sender != null) {
          return Scaffold(
            appBar: buildAppBar(),
            body: buildBody(),
          );
        }
        return const LoadingWidget();
      },
    );

  }

  Column buildBody() {
    return Column(children: [
            Expanded(
             child: ChatList(receiverUserId:receiver!.uid),
            ),
            BottomChatField(receiverUser: receiver!,senderUser: sender!,),
          ]);
  }

  AppBar buildAppBar() {
    return AppBar(
            scrolledUnderElevation: 15,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(receiver!.profilePic),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),

                Text(
                  receiver!.name,
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
