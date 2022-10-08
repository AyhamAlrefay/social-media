
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
    return
    Text(message,
      maxLines: null,
      style: const TextStyle(
        fontSize: 14,

      ));

  }
}
