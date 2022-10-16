import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/features/chat/presentation/pages/chat_user.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';

class AllContacts extends StatefulWidget {
final List<UserEntity> listUser;
  const AllContacts({Key? key, required this.listUser}) : super(key: key);

   @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  List<Contact> _contacts=[];
  List<UserEntity> listSearchUser=[];
final TextEditingController _searchController=TextEditingController();
  bool _permissionDenied = false;

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(
      readonly: true,
    )) {
      setState(() {
        _permissionDenied = true;
      });
    } else {
      final contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
          withThumbnail: true,
        );
      setState(() {
        _contacts = contacts;
      });
    }
  }

  @override
  void dispose() {
    listSearchUser.clear();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _fetchContacts();

  }
 late List<UserEntity> listContacts;
 late UserEntity senderUser;
  @override
  Widget build(BuildContext context) {
     listContacts=[];
    for (var element in widget.listUser) {
      for (int i = 0; i < _contacts.length; i++) {
        if (element.phoneNumber == _contacts[i].phones[0].normalizedNumber) {
      if(element.uid==FirebaseAuth.instance.currentUser!.uid)
        {
          senderUser=element;
          continue;
        }
          listContacts.add(element);
        }
      }
    }
    return Scaffold(
      appBar: AppBar(

      ),
      body:

      listContacts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listContacts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:NetworkImage(listContacts[index].profilePic),
                      radius: 25,
                    ),
                    title: Text(
                      listContacts[index].name,
                      style: const TextStyle(fontSize: 15),
                    ),
                    subtitle:
                        Text(listContacts[index].phoneNumber),
                    onTap: () async {
                      BlocProvider.of<GetMessageUserBloc>(context)
                          .add(GetChatMessageUserEvent(
                          receiverUserId: listContacts[index].uid));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatUser(receiver: listContacts[index], sender: senderUser)));
                    },
                  ),
                );
              },
            ),
    );
  }

//
//   void addSearchedFOrItemsToSearchedList(String searchedUser) {
//     listSearchUser = listContacts
//         .where((users) => (users.name)
//         .replaceAll(' ', '')
//         .contains(searchedUser))
//         .toList();
//     setState(() {});
//   }
//
//   Widget _buildSearchField() {
//     return TextField(
//       controller: _searchController,
//       cursorColor: Colors.yellowAccent,
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//         hintText: 'Search...',
//         hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
//       ),
//       onChanged: (name) {
//         addSearchedFOrItemsToSearchedList(name.replaceAll(' ', ''));
//       },
//     );
//   }
//
//
//
//
// buildBody() {
//   return  listSearchUser== null
//       ? const Text('')
//       : Padding(
//     padding: const EdgeInsets.only(top: 20),
//     child: ListView.separated(
//       itemCount: listSearchUser.length,
//       itemBuilder: (BuildContext context, index) {
//         return Dismissible(
//           key: UniqueKey(),
//           direction: DismissDirection.endToStart,
//           onDismissed: (_) {
//             setState(() {
//               listSearchUser.removeAt(index);
//             });
//           },
//           child: ListTile(
//             onTap: (){},
//             leading: CircleAvatar(
//               radius: 35,
//             ),
//             title: Text(
//               '${listSearchUser[index].name}',
//               style:  TextStyle(color: Theme.of(context).colorScheme.secondary),
//             ),
//           ),
//           background: Container(
//             color: Colors.red,
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             alignment: Alignment.centerRight,
//             child: const Icon(
//               Icons.delete,
//               color: Colors.white,
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (BuildContext context, int index) =>
//       const SizedBox(
//         height: 20,
//       ),
//     ),
//   );
// }
}