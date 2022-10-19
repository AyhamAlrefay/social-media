import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:intl/intl.dart';
import '../../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';
import '../../pages/chat_user.dart';
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
          style: Theme.of(context).textTheme.bodySmall,
        ),
        subtitle: chatContact.lastMessage.contains('https')? RichText(text: TextSpan(
          children: [
            TextSpan(text: 'image',style: Theme.of(context).textTheme.displayMedium),
           const  WidgetSpan(child: Icon(Icons.image),alignment: PlaceholderAlignment.middle)
          ]
        ), ): Text( chatContact.lastMessage,style: Theme.of(context).textTheme.displayMedium,),
        trailing: Text(
          DateFormat('hh:mm a').format(chatContact.timeSent),
          style: const TextStyle(fontSize: 12,color: Colors.black54),
        ),
        onTap: () async {
          BlocProvider.of<GetUsersDataBloc>(context)
            ..add(GetOtherUsersData(
                receiverUserId: chatContact.contactId.replaceAll(' ', '')))
            ..add(GetCurrentUserData());
          BlocProvider.of<GetMessageUserBloc>(context)
            .add(GetChatMessageUserEvent(
                receiverUserId: chatContact.contactId.replaceAll(' ', '')));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ChatUser();
          }));
        },
      ),
    );
  }
}
