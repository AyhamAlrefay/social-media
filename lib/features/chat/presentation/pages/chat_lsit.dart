import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/chat/presentation/bloc/get_message_user/get_message_user_bloc.dart';
import 'package:whatsapp/injection_container.dart' as di;
import '../../../../core/enums/enum_message.dart';
import '../../domain/entities/message.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/message_replt.dart';
import '../widgets/chat_screen/my_message_card.dart';
import '../widgets/chat_screen/sender_message_card.dart';

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

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    MessageReply(
      message: message,
      isMe: isMe,
      messageEnum: messageEnum,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetMessageUserBloc>(
        create: (context) => di.sl<GetMessageUserBloc>()
          ..add(GetChatMessageUserEvent(receiverUserId: widget.receiverUserId)),
        child: BlocBuilder<GetMessageUserBloc,GetMessageUserState>(

        builder: (context,state) {
          if(state is GetMessageUserStateSuccess) {
            return StreamBuilder<List<Message>>(
              stream:state.message ,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  messageController
                      .jumpTo(messageController.position.maxScrollExtent);
                });
                return ListView.builder(
                  controller: messageController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var messageData = snapshot.data![index];
                    var timeSent = DateFormat.Hm().format(messageData.timeSent);
                    if (messageData.senderId == FirebaseAuth.instance.currentUser!.uid) {
                      return MyMessageCard(
                        message: messageData.text,
                        date: timeSent,
                        type: messageData.type,
                        isSeen: messageData.isSeen,
                        onLeftSwipe: () =>
                            onMessageSwipe(
                                messageData.text, true, messageData.type),
                        repliedText: messageData.repliedMessage,
                        username: messageData.repliedTo,
                        repliedMessageType: messageData.repliedMessageType,
                      );
                    }
                    return SenderMessageCard(
                      message: messageData.text,
                      date: timeSent,
                      type: messageData.type,
                      onRightSwipe: () =>
                          onMessageSwipe(
                              messageData.text, false, messageData.type),
                      repliedText: messageData.repliedMessage,
                      username: messageData.repliedTo,
                      repliedMessageType: messageData.repliedMessageType,
                    );
                  },
                );
              });
          }
          return const CircularProgressIndicator();
        }

        ));
  }
}
