import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/presentation/bloc/save_data/save_data_bloc.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/entities/message_reply.dart';
import '../../bloc/get_messages_user/get_message_user_bloc.dart';
import 'display_text_image.dart';
import 'package:whatsapp/injection_container.dart' as di;

class ReceiverMessageCard extends StatelessWidget {
  final Message message;

  ReceiverMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: () {
        BlocProvider.of<SaveDataBloc>(context)
            .add(ChangeMessageReplyToDataEvent(MessageReply(
          message: message.text,
          isMe: FirebaseAuth.instance.currentUser!.uid == message.senderId,
          messageEnum: message.type,
        )));
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.grey.shade400,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Stack(
              children: [
                Padding(
                  padding: message.type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 5,
                          bottom: 10,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      if (message.repliedMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                message.receiverUserName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 3),
                              DisplayTextImage(
                                message: message.repliedMessage!,
                                type: message.repliedMessageType!,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      DisplayTextImage(
                        message: message.text,
                        type: message.type,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DateFormat('hh:mm a').format(message.timeSent),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
