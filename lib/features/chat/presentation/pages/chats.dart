import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessageUserAndContactsBloc,
        GetMessageUserAndContactsState>(builder: (context, state) {
      if (state is GetContactsError) {
        return const LoadingWidget();
      } else if (state is GetContactsSuccess) {
        return StreamBuilder<List<ChatContact>>(
            stream: state.contacts,
            builder: (context, snapShot) {
              return Scaffold(
                body: snapShot.data!.isEmpty
                    ? const Center(
                        child: Text('There are not any contacts'),
                      )
                    : ListView.builder(
                        itemCount: snapShot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:const EdgeInsets.only(bottom: 15),
                            child: ListTile(
                              leading:  CircleAvatar(
                                backgroundImage: NetworkImage(
                                  snapShot.data![index].profilePic),
                                radius: 25,
                              ),
                              title: Text(
                                snapShot.data![index].name,
                                style: const TextStyle(fontSize: 15),
                              ),
                              onTap: () async {
                                BlocProvider.of<SaveUserDataBloc>(context).add(GetUserData(userId: snapShot.data![index].contactId));
                                Navigator.of(context).pushNamed(ChatUser.routeName);
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
