import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/save_data/save_data_bloc.dart';
import 'display_text_image.dart';

class SenderMessageCard extends StatelessWidget {
  final Message message;

  const SenderMessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, myProvider, child) {
      return SwipeTo(
        onLeftSwipe: () {
          BlocProvider.of<SaveDataBloc>(context).add(
              ChangeMessageReplyToDataEvent(
                  messageReply: MessageReply(
                      message: message.messageContent,
                      isMe: FirebaseAuth.instance.currentUser!.uid ==
                          message.senderId,
                      messageEnum: message.type)));
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                color: Color.fromRGBO(5, 100, 100, 1),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                children: [
                  Padding(
                    padding: message.type == MessageEnum.text
                        ? const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 8,
                            bottom: 5,
                          )
                        : const EdgeInsets.only(
                            left: 5,
                            top: 5,
                            right: 5,
                            bottom: 25,
                          ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (message.repliedMessage != null) ...[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  message.senderUserName!,
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
                          const SizedBox(height: 8),
                        ],
                        DisplayTextImage(
                          message: message.messageContent,
                          type: message.type,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(message.timeSent),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white38,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Icon(
                              message.isSeen ? Icons.done_all : Icons.done,
                              size: 20,
                              color: message.isSeen ? Colors.blue : Colors.white38,
                            ),
                          ],
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
    });
  }
}
