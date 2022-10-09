import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:intl/intl.dart';
import '../../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';
import '../../bloc/send_messages_user/send_message_user_bloc.dart';
import '../../pages/chat_user.dart';
import 'package:whatsapp/injection_container.dart' as di;

class ChatContactsItemWidget extends StatelessWidget {
  final ChatContact chatContact;

  const ChatContactsItemWidget({Key? key, required this.chatContact})
      : super(key: key);

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

       Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiBlocProvider(
         providers: [
       BlocProvider<SendMessageUserBloc>(
       create: (_) => di.sl<SendMessageUserBloc>()),
       BlocProvider<GetUsersDataBloc>(
           create: (_) => di.sl<GetUsersDataBloc>()
             ..add(GetCurrentUserData())
             ..add(GetOtherUsersData(
                 receiverUserId:
                 chatContact.contactId.replaceAll(' ', '')))),
           BlocProvider<GetMessageUserBloc>(
             create: (_) => di.sl<GetMessageUserBloc>()
               ..add(GetChatMessageUserEvent(
                   receiverUserId:
                   chatContact.contactId.replaceAll(' ', ''))),)

         ], child: ChatUser() ,
       )));


        },
      ),
    );
  }
}
