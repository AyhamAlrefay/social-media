import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/features/mobile_chat_screen/presentation/pages/chat_screen.dart';

class Chats extends StatefulWidget {
  static const String routeName = '/chats';

  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() {
        _permissionDenied = true;
      });
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() {
        _contacts = contacts;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contacts==null?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, index) {
          return Padding(padding:EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
              radius: 25,
            ),
            title: Text(_contacts![index].displayName,style: TextStyle(fontSize: 15),),
            onTap: () async {
              final fullContact =
              await FlutterContacts.getContact(_contacts![index].id);
              Navigator.of(context).pushNamed(ChatUser.routeName,arguments:fullContact,);

            },
          ),
          );
        },
      ),
    );
  }
}
