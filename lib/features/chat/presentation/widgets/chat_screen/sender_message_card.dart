import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../../core/enums/enum_message.dart';
import 'display_text_image.dart';


class SenderMessageCard extends StatelessWidget {

  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
             decoration: BoxDecoration( borderRadius:const BorderRadius.only( bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),),
               color: Colors.grey.shade400,),

            margin: const EdgeInsets.symmetric(horizontal: 10, vertical:12),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
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
                      if (isReplying) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration:const BoxDecoration(
                            color:Colors.white54,
                            borderRadius:BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                              ),
                            ),
                          child: Column(
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 3),
                              DisplayTextImage(
                                message: repliedText,
                                type: repliedMessageType,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      DisplayTextImage(
                        message: message,
                        type: type,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[600],
                    ),
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