import 'package:flutter/material.dart';
import 'package:whatsapp/core/theme/colors.dart';
class BottomChatField extends StatefulWidget {
  
  const BottomChatField({Key? key}) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isShowSendButton=true;
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextFormField(
          controller:messageController ,
          decoration: InputDecoration(
            hintText: 'Type a message!',
            border: OutlineInputBorder(
              borderRadius:BorderRadius.circular(20),
              borderSide:const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
              contentPadding: const EdgeInsets.all(10),
            filled: true,
            fillColor: backgroundColor,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
        Padding(padding:EdgeInsets.only(
          bottom: 8,
          right: 2,
          left: 2,
        ),
          child: GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 25,
              child: Icon(
                isShowSendButton? Icons.send:Icons.mic,
              )
            ),
          ),
        ),

      ],
    );
  }
}
