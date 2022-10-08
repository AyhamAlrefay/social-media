
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
import '../../../auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import '../../data/models/contact_model.dart';
import 'chat_user.dart';
import 'package:intl/intl.dart';

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
                                radius: 30,
                              ),

                              title: Text(
                                listContact[index].name,
                                style: const TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(listContact[index].lastMessage),
                              trailing:Text('${DateFormat('hh:mm a').format(listContact[index].timeSent)}',style:const TextStyle(fontSize: 12),),
                              onTap: () async {
                                BlocProvider.of<SaveUserDataBloc>(context).add(
                                    GetUserData(
                                        userId:
                                        listContact[index].contactId.replaceAll(' ', '')));
                                BlocProvider.of<GetMessageUserAndContactsBloc>(
                                        context)
                                    .add(GetChatMessageUserEvent(
                                        receiverUserId:
                                        listContact[index].contactId.replaceAll(' ', '')));
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
          else{
            return Container();
   }
    },
    buildWhen: (GetContactsLoading,state){
          return state is!GetContactsError;
    },
    );
  }
}
