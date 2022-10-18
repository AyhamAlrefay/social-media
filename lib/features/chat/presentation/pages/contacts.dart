import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/global/theme/colors.dart';
import 'package:whatsapp/core/widgets/snak_bar.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_contacts/all_contacts.dart';
import '../../../../core/strings/string_public.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import '../../domain/entities/contact.dart';
import '../bloc/get_contacts_user/get_contacts_user_bloc.dart';
import '../widgets/chat_contacts/chat_contacts_item_widget.dart';

class Contacts extends StatefulWidget {
  static const String routeName = '/contacts';

  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<UserEntity> listUsers = [];

  @override
  void initState() {
    BlocProvider.of<GetUsersDataBloc>(context).add(GetAllUsersData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<GetUsersDataBloc, GetUsersDataState>(
            builder: (context, state) {
          if (state is GetAllUsersDataSuccess) {
            listUsers = state.listUsers;
          }

          return BlocBuilder<GetContactsUserBloc, GetContactsUserState>(
            builder: (context, state) {
              if (state is GetContactsUserSuccess) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: state.contacts,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      final List<ChatContact> listContact =
                          createChatContacts(snapshot);
                      return Scaffold(
                        body: listContact.isEmpty
                            ? const Center(
                                child: Text(THERE_ARENOT_CONTACTS),
                              )
                            : ListView.builder(
                                itemCount: listContact.length,
                                itemBuilder: (context, index) {
                                  return ChatContactsItemWidget(
                                    chatContact: listContact[index],
                                  );
                                },
                              ),
                      );
                    });
              }
              if (state is GetContactsUserError) {
                showSnackBar(context: context, content: state.error);
              }
              return const LoadingWidget();
            },
            buildWhen: (previous, current) {
              return previous != current;
            },
          );
        }),
        floatingActionButton: FloatingActionButton(

          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AllContacts(listUser: listUsers)));
          },
          child:  Icon(
            Icons.message,
            color: Theme.of(context).iconTheme.color,
          ),
        ));
  }

  List<ChatContact> createChatContacts(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return snapshot.data!.docs
        .map((e) => ChatContact(
            name: e['name'],
            profilePic: e['profilePic'],
            contactId: e['contactId'],
            timeSent: DateTime.parse(e['timeSent'].toDate().toString()),
            lastMessage: e['lastMessage']))
        .toList();
  }
}
