
import 'package:flutter/material.dart';

import '../../../../../core/enums/enum_message.dart';


class DisplayTextImage extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImage({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return type.type=='image'?ConstrainedBox(

      constraints: BoxConstraints(
        maxWidth:  MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height/3,
      ),
      child: Image(image: NetworkImage(
        message
      )),
    ):Text(message,
      maxLines: null,
      style: const TextStyle(
        fontSize:16 ,
color: Colors.white
      ));

  }
}
