import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/global/theme/colors.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import 'package:whatsapp/features/chat/presentation/bloc/save_data/save_data_bloc.dart';
import '../../../../../core/enums/enum_message.dart';
import 'display_text_image.dart';

class MessageReplyPreview extends StatelessWidget {
 MessageReply? messageReply;
 final String senderName;
 final String receiverName;
   MessageReplyPreview(
      {Key? key,
  required this.messageReply, required this.senderName, required this.receiverName})
      : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 350,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color:Color.fromRGBO(5, 100, 100, 1),
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.yellowAccent,
                    ),
                    onTap: () {
                      BlocProvider.of<SaveDataBloc>(context).add(ChangeMessageReplyToNullEvent(messageReply: null));
                     },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DisplayTextImage(
                      message: messageReply!.message,
                      type: messageReply!.messageEnum,
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
