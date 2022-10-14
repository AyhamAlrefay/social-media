import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:intl/intl.dart';
import '../../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';
import '../../bloc/save_data/save_data_bloc.dart';
import '../../bloc/send_messages_user/send_message_user_bloc.dart';
import '../../pages/chat_user.dart';
import 'package:whatsapp/injection_container.dart' as di;



class ChatContactsItemWidget extends StatelessWidget {
  final ChatContact chatContact;
  ChatContactsItemWidget({Key? key, required this.chatContact})
      : super(key: key);
  UserEntity? sender;
  UserEntity? receiver;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chatContact.profilePic),
          radius: 30,
        ),
        title: Text(
          chatContact.name,
          style: const TextStyle(fontSize: 15),
        ),
        subtitle: Text(chatContact.lastMessage),
        trailing: Text(
          DateFormat('hh:mm a').format(chatContact.timeSent),
          style: const TextStyle(fontSize: 12),
        ),
        onTap: () async {

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<SendMessageUserBloc>(
                    create: (_) => di.sl<SendMessageUserBloc>()),
                BlocProvider<GetUsersDataBloc>(
                  create: (_) => di.sl<GetUsersDataBloc>()
                    ..add(GetOtherUsersData(
                        receiverUserId:
                            chatContact.contactId.replaceAll(' ', '')))
                    ..add(GetCurrentUserData()),
                ),
                BlocProvider<GetMessageUserBloc>(
                    create: (_) => di.sl<GetMessageUserBloc>()
                      ..add(GetChatMessageUserEvent(
                          receiverUserId:
                              chatContact.contactId.replaceAll(' ', '')))),
            BlocProvider<SaveDataBloc>(create:(_)=>di.sl<SaveDataBloc>()),
              ],
              child: BlocConsumer<GetUsersDataBloc, GetUsersDataState>(
                listener: (BuildContext context, state) {
                  if (state is GetCurrentUserDataSuccess) {
                    sender = state.currentUser;
                  }
                  if (state is GetOtherUserDataSateSuccess) {
                    receiver = state.otherUser;
                  }
                },
                builder: (BuildContext context, state) {
                  if(receiver!=null && sender!=null) {
                    return ChatUser(
                      receiver: receiver!,
                      sender: sender!,
                  );
                  }
                  return const LoadingWidget();
                },
              ),
            );
          }));
},
      ),
    );
  }
}
