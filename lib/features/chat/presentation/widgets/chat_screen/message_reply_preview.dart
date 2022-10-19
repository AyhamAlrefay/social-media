import 'package:flutter/material.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import 'package:whatsapp/features/chat/presentation/bloc/managing_state_variables_in_chat_screen/managing_state_variables_in_chat_screen_bloc.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/bottom_chat_field.dart';
import 'display_text_image.dart';

class MessageReplyPreview extends StatelessWidget {
  MessageReply? messageReply;
  final String senderName;
  final String receiverName;

  MessageReplyPreview(
      {Key? key,
      required this.messageReply,
      required this.senderName,
      required this.receiverName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 350,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(5, 100, 100, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      messageReply!.isMe ? senderName : receiverName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.yellowAccent,
                    ),
                    onTap: () {
                      BottomChatField.managingStateVariablesBloc3
                          .add(DeleteMessageReplyEvent());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding:  EdgeInsets.only(left: 8, right: 3),
                        child: messageReply!.messageEnum.type == 'image'
                            ?Text(messageReply!.message,
                              overflow: TextOverflow.clip,
                                maxLines: null,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white))

                            : DisplayTextImage(
                                message: messageReply!.message,
                                type: messageReply!.messageEnum,

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
