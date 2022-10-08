import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:whatsapp/features/chat/presentation/bloc/get_message_user_and_contacts/get_message_user_and_contacts_bloc.dart';
import '../../../auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'chat_user.dart';

class Chats extends StatefulWidget {
  static const String routeName = '/chats';

  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetMessageUserAndContactsBloc>(context)
        .add(GetContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessageUserAndContactsBloc,
        GetMessageUserAndContactsState>(builder: (context, state) {
          if(state is GetContactsLoading) {
            return const LoadingWidget();
          }
   if (state is GetContactsSuccess) {
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: state.contacts,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting) {
                return const LoadingWidget();
              }
              final listContact = snapshot.data!.docs
                  .map((e) => ChatContact(
                      name: e['name'],
                      profilePic: e['profilePic'],
                      contactId: e['contactId'],
                      timeSent:  DateTime.parse(e['timeSent'].toDate().toString()),
                      lastMessage: e['lastMessage']))
                  .toList();
              return Scaffold(
                body:listContact.isEmpty
                    ? const Center(
                        child: Text('There are not any contacts'),
                      )
                    : ListView.builder(
                        itemCount: listContact.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(listContact[index].profilePic),
                                radius: 25,
                              ),
                              title: Text(
                                listContact[index].name,
                                style: const TextStyle(fontSize: 15),
                              ),
                              onTap: () async {
                                BlocProvider.of<SaveUserDataBloc>(context).add(
                                    GetUserData(
                                        userId:
                                        listContact[index].contactId));
                                BlocProvider.of<GetMessageUserAndContactsBloc>(
                                        context)
                                    .add(GetChatMessageUserEvent(
                                        receiverUserId:
                                        listContact[index].contactId));
                                Navigator.of(context)
                                    .pushNamed(ChatUser.routeName);
                              },
                            ),
                          );
                        },
                      ),
              );
            });
      }
    return Container();
    });
  }
}
