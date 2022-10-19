import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/bottom_chat_field.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/managing_state_variables_in_chat_screen/managing_state_variables_in_chat_screen_bloc.dart';
import 'display_text_image.dart';
import 'package:drop_cap_text/drop_cap_text.dart';

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
          BottomChatField.managingStateVariablesBloc3.add(
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
              maxWidth: MediaQuery.of(context).size.width - 60,
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
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Stack(
                children: [
                  Padding(
                    padding: message.type == MessageEnum.text
                        ? const EdgeInsets.only(
                            left: 4, right: 4, top: 4, bottom: 12)
                        : const EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 25),
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          if (message.repliedMessage != null &&
                              message.repliedTo != '') ...[
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          if (message.repliedTo == ' ') ...[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight: MediaQuery.of(context).size.height / 3,
                              ),
                              child: Image(
                                  image: NetworkImage(message.messageContent)),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(right: 8,left: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                    child: DisplayTextImage(
                                      message: message.messageContent,
                                      type: message.type,
                                ),),
                              const SizedBox(
                                  width: 12,
                                ),
                                Row(
                                  mainAxisSize:MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        DateFormat('hh:mm a')
                                            .format(message.timeSent),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      message.isSeen ? Icons.done_all : Icons.done,
                                      size: 20,
                                      color: message.isSeen
                                          ? Colors.blue
                                          : Colors.white60,
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
