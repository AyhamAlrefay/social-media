import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/snak_bar.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';
import 'sender_message_card.dart';
import 'receiver_message_card.dart';

class ChatList extends StatefulWidget {
  static const String routeName = '/chat-list';
  final String receiverUserId;

  const ChatList({Key? key, required this.receiverUserId}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessageUserBloc,
        GetMessageUserState>(builder: (context, state) {
      if (state is GetMessageUserStateSuccess) {
        return StreamBuilder(
            stream: state.messages,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              SchedulerBinding.instance.addPostFrameCallback((_) {
                messageController
                    .jumpTo(messageController.position.maxScrollExtent);
              });

              List<Message> listMessage = listMessages(snapshot);
              return ListView.builder(
                controller: messageController,
                itemCount: listMessage.length,
                itemBuilder: (context, index) {
                  var messageData = listMessage;
                  if (messageData[index].senderId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return SenderMessageCard(
                      message: messageData[index],
                    );
                  }
                  return ReceiverMessageCard(
                    message: messageData[index],
                  );
                },
              );
            });
      } else if (state is GetMessageUserStateError) {
        showSnackBar(context: context, content:state.error );
      }
      return const Text('');
    });
  }
  List<Message> listMessages(AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
    return snapshot.data!.docs
        .map((e) => Message(
        senderId: e['senderId'],
        receiverId: e['receiverId'],
        messageContent: e['messageContent'],
        type:(e['type'] as String).toEnum(),
        timeSent: DateTime.parse(e['timeSent'].toDate().toString()),
        messageId: e['messageId'],
        isSeen: e['isSeen']))
        .toList();
  }
}