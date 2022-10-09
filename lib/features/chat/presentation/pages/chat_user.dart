import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/chat_screen/bottom_chat_field.dart';
import '../widgets/chat_screen/chat_lsit.dart';

class ChatUser extends StatelessWidget {
  static const String routeName = '/chat-user';
UserEntity? senderUser;
UserEntity? receiverUser;

 ChatUser({super.key,  this.senderUser, this.receiverUser});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUsersDataBloc, GetUsersDataState>(
      listener:(context, state) {
        if(state is GetOtherUserDataSateSuccess ) {
          receiverUser=state.otherUser;
        }
        if(state is GetCurrentUserDataSuccess){
          senderUser=state.currentUser;
        }
      } ,
      builder: (context, state) {

          return Scaffold(
            appBar: buildAppBar(),
            body: buildBody(),
          );
      },);
  }

  Column buildBody() {
    return Column(children: [
            Expanded(
              child: ChatList(receiverUserId:receiverUser!.uid),
            ),
            BottomChatField(receiverUser: receiverUser!,senderUser:senderUser!,),
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
                  backgroundImage: NetworkImage(receiverUser!.profilePic),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),

                Text(
                  receiverUser!.name,
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
