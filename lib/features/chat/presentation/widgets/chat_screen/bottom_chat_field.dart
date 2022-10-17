import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/bottom_chat_field/bottom_sheet.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/message_reply_preview.dart';
import '../../../../../core/enums/enum_message.dart';
import '../../../../../core/global/theme/colors.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/save_data/save_data_bloc.dart';
import '../../bloc/send_messages_user/send_message_user_bloc.dart';
import '../../pages/camer_screen.dart';

class BottomChatField extends StatefulWidget {
  final UserEntity receiverUser;
  final UserEntity senderUser;


  const BottomChatField(
      {Key? key, required this.receiverUser, required this.senderUser})
      : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isShowSendButton = false;
  TextEditingController messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  XFile? image;

  late SaveDataBloc saveDataBloc;
  MessageReply? messageReply;

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocBuilder<SaveDataBloc, SaveDataState>(
          builder: (context, state) {
            if (state is ChangeMessageRelyToData) {
              messageReply = state.messageReply;
              return MessageReplyPreview(
                messageReply: state.messageReply,
                senderName: widget.senderUser.name,
                receiverName: widget.receiverUser.name,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),

                  child: buildTextFormField(context),


                )),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: GestureDetector(
                onTap: () {
                  final timeSent = DateTime.now();
                  var messageId = const Uuid().v1();
                  final Message message = messageReply != null ? Message(
                    senderId: widget.senderUser.uid,
                    receiverId: widget.receiverUser.uid,
                    messageContent: messageController.text,
                    type: MessageEnum.text,
                    timeSent: timeSent,
                    messageId: messageId,
                    isSeen: false,
                    senderUserName: widget.senderUser.name,
                    receiverUserName: widget.receiverUser.name,
                    repliedMessage: messageReply!.message,
                    repliedMessageType: messageReply!.messageEnum,
                    repliedTo: messageReply!.isMe == true
                        ? widget.senderUser.name
                        : widget.receiverUser.name,
                  )
                      : Message(
                      senderId: widget.senderUser.uid,
                      receiverId: widget.receiverUser.uid,
                      messageContent: messageController.text,
                      type: MessageEnum.text,
                      timeSent: timeSent,
                      messageId: messageId,
                      isSeen: false);
                  messageReply = null;
                  BlocProvider.of<SendMessageUserBloc>(context).add(
                      SendMessageUser(
                          message: message,
                          senderUser: widget.senderUser,
                          receiverUser: widget.receiverUser));
                  setState(() {
                    messageController.clear();
                    BlocProvider.of<SaveDataBloc>(context)
                        .add(ChangeMessageReplyToNullEvent(messageReply: null));
                  });
                },
                child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(5, 96, 98, 1),
                    radius: 25,
                    child: Icon(
                      isShowSendButton ? Icons.send : Icons.mic,
                      color: Theme.of(context).iconTheme.color,
                    )),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.35,
          ),
          child: EmojiPicker(
            onEmojiSelected: ((category, emoji) {
              setState(() {
                messageController.text =
                    messageController.text + emoji.emoji;
              });

              if (!isShowSendButton) {
                setState(() {
                  isShowSendButton = true;
                });
              }
            }),
          ),
        )
            : const SizedBox(),
      ],
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      minLines: 1,
      onTap: () {
        setState(() {
          isShowEmojiContainer = false;
        });
      },
      autofocus: true,
      focusNode: focusNode,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      controller: messageController,
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            isShowSendButton = false;
          } else {
            isShowSendButton = true;
          }
        });
      },
      decoration: InputDecoration(
        hintText: 'Type a message!',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: const Color.fromRGBO(5, 96, 98, 1),
        prefixIcon: IconButton(
          onPressed: toggleEmojiKeyboardContainer,
          icon:  Icon(
            Icons.emoji_emotions,
            color:Theme.of(context).iconTheme.color,
          ),
        ),
        suffixIcon: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CameraScreen(
                            receiverUser: widget.receiverUser,
                            senderUser: widget.senderUser,
                          )));
                },
                icon:  Icon(
                  Icons.camera_alt,
                  color:Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () async {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1000.0))),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                    anchorPoint: const Offset(5, 10),
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                    ),
                    elevation: 20,
                    enableDrag: true,
                    context: context,
                    builder: (builder) =>
                        BottomSheetWidget(context: context,
                          senderUser: widget.senderUser,
                          receiverUser: widget.receiverUser,),
                  );
                },
                icon:  Icon(
                  Icons.attach_file,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
