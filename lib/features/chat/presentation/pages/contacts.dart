import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/theme/colors.dart';
import 'package:whatsapp/core/widgets/snak_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/contact.dart';
import '../bloc/get_contacts_user/get_contacts_user_bloc.dart';
import '../widgets/chat_contacts/chat_contacts_item_widget.dart';

class Chats extends StatefulWidget {
  static const String routeName = '/chats';

  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocConsumer<GetContactsUserBloc, GetContactsUserState>(
        listener: (context,state){

        },
          builder: (context, state) {
            if (state is GetContactsUserSuccess) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: state.contacts,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    }
                    final List<ChatContact> listContact =createChatContacts(snapshot);
                    return Scaffold(
                      body: listContact.isEmpty
                          ? const Center(
                              child: Text('There are not any contacts'),
                            )
                          : ListView.builder(
                              itemCount: listContact.length,
                              itemBuilder: (context, index) {
                                return ChatContactsItemWidget( chatContact:listContact[index],);
                              },
                            ),
                    );
                  });
            }
            if(state is GetContactsUserError) {
              showSnackBar(context: context, content: state.error);
            }
            return const LoadingWidget();
          },
          buildWhen: (previous,  current) {
            return previous !=current;
          },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){},
      child: const Icon(Icons.message,color: Colors.yellowAccent,),
      ),
    );
  }
  List<ChatContact>createChatContacts(AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
    return  snapshot.data!.docs
        .map((e) => ChatContact(
        name: e['name'],
        profilePic: e['profilePic'],
        contactId: e['contactId'],
        timeSent: DateTime.parse(e['timeSent'].toDate().toString()),
        lastMessage: e['lastMessage']))
        .toList();
  }
}
