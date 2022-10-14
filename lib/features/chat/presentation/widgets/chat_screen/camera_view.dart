import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/enums/enum_message.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/send_messages_user/send_message_user_bloc.dart';
class CameraViewPage extends StatelessWidget {
  final UserEntity receiverUser;
  final UserEntity senderUser;
  const CameraViewPage({ Key? key, required this.file, required this.receiverUser, required this.senderUser}) : super(key: key);
  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.title,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.edit,
                size: 27,
              ),
              onPressed: () {}),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(file.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Caption....",
                      prefixIcon: const Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: 27,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.tealAccent[700],
                        child:  IconButton(
                         icon:const Icon( Icons.check,size: 27,),
                          color: Colors.white, onPressed: () {
                           Message message;
                          final timeSent = DateTime.now();
                          var messageId = const Uuid().v1();
                         message= Message(
                              senderId: senderUser.uid,
                              receiverId: receiverUser.uid,
                              messageContent: file,
                              type: MessageEnum.image,
                              timeSent: timeSent,
                              messageId: messageId,
                              isSeen: false);

                          BlocProvider.of<SendMessageUserBloc>(context).add(
                              SendMessageUser(
                                  message: message,
                                  senderUser: senderUser,
                                  receiverUser: receiverUser));
                           int count = 0;
                           Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}