import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/core/theme/colors.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/chat/domain/entities/contact.dart';
import 'package:whatsapp/features/chat/presentation/bloc/get_message_user_and_contacts/get_message_user_and_contacts_bloc.dart';

import '../../../../core/widgets/snak_bar.dart';
import '../../../auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import '../../data/models/contact_model.dart';
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
        GetMessageUserAndContactsState>(
      builder: (context, state) {
        if (state is GetContactsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetContactsSuccess) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: state.contacts,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                if(snapShot.connectionState==ConnectionState.waiting)
                  {
                    return const LoadingWidget();
                  }
                List<ChatContact> chatContacts = snapShot.data!.docs
                    .map((element) => ChatContact(
                        name: element['name'],
                        profilePic: element['profilePic'],
                        contactId: element['contactId'],
                        timeSent: DateTime.parse(
                            element['timeSent'].toDate().toString()),
                        lastMessage: element['lastMessage']))
                    .toList();
                return Scaffold(
                  body: !snapShot.hasData
                      ? const Center(
                          child: Text('There are not any contacts'),
                        )
                      : ListView.builder(
                    itemCount: chatContacts.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                            NetworkImage(chatContacts[index].profilePic),
                            radius: 25,
                          ),
                          title: Text(
                            chatContacts[index].name,
                            style: const TextStyle(fontSize: 15),
                          ),
                          onTap: () async {
                            BlocProvider.of<SaveUserDataBloc>(context)
                                .add(GetUserData(
                                userId: chatContacts[index].contactId.replaceAll(' ', '')));
                            BlocProvider.of<
                                GetMessageUserAndContactsBloc>(
                                context)
                                .add(GetChatMessageUserEvent(
                                receiverUserId:
                                chatContacts[index].contactId));
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
      },
    );
  }
}
