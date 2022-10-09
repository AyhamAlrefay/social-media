import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../domain/entities/message.dart';
import 'display_text_image.dart';


class SenderMessageCard extends StatelessWidget {
final Message message;
  const SenderMessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: (){},
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
            decoration:const BoxDecoration(
            borderRadius: BorderRadius.only( bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),),
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
                    bottom: 18,
                  )
                      : const EdgeInsets.only(
                    left: 5,
                    top: 5,
                    right: 5,
                    bottom: 25,
                  ),
                  child: Column(
                    children: [
                      if ( message.repliedMessage!=null) ...[

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration:const BoxDecoration(
                            color:Colors.white24,
                            borderRadius:BorderRadius.only(
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
                                  fontWeight: FontWeight.bold,color: Colors.green,
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
                        message: message.text,
                        type: message.type,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('hh:mm a').format(message.timeSent),
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            message.isSeen ? Icons.done_all : Icons.done,
                            size: 15,
                            color: message.isSeen ? Colors.blue : Colors.white60,
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
  }
}
