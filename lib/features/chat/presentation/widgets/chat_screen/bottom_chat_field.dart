import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply.dart';
import 'package:whatsapp/features/chat/presentation/bloc/managing_state_variables_in_chat_screen/managing_state_variables_in_chat_screen_bloc.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/bottom_chat_field/bottom_sheet.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/message_reply_preview.dart';
import '../../../../../core/enums/enum_message.dart';
import 'package:whatsapp/injection_container.dart' as di;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManagingStateVariablesInChatScreenBloc>(
      create: (buildContext) => di.sl<ManagingStateVariablesInChatScreenBloc>(),
      child: Builder(
        builder: (BuildContext buildContext) {
          return Column(
              children: [
                BlocConsumer<SaveDataBloc, SaveDataState>(
                  listener: (context,state){
                     if(state is NotMessageReply){
                    messageReply=null;

                    }
                  },
                  builder: (context, state) {
                    if (state is ChangeMessageRelyToData) {
                      messageReply = state.messageReply;
                      return MessageReplyPreview(
                        messageReply: state.messageReply,
                        senderName: widget.senderUser.name,
                        receiverName: widget.receiverUser.name,
                      );
                    }
                    else{
                      return const SizedBox();
                    }
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: buildTextFormField(buildContext),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 2,
                        left: 2,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<SendMessageUserBloc>(context).add(
                              SendMessageUser(
                                  message: buildMessage(),
                                  senderUser: widget.senderUser,
                                  receiverUser: widget.receiverUser));
                          BlocProvider.of<SaveDataBloc>(context).add(DeleteMessageReply(messageReply: null));
                            messageController.clear();
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
                BlocConsumer<ManagingStateVariablesInChatScreenBloc,
                    ManagingStateVariablesInChatScreenState>(
                    listener: (context, state) {
                      if (state is NotShowKeyboardEmoji) {
                        isShowEmojiContainer = state.isShowEmojiKeyboard;
                      }
                      if(state is NotShowSendButtonState)
                        {
                          isShowSendButton=state.notShowSendButton;
                        }
                    }, builder: (context, state) {
                  if (state is ShowKeyboardEmojiState) {
                    isShowEmojiContainer = state.isShowEmojiKeyboard;
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                        MediaQuery.of(context).size.height * 0.35,
                      ),
                      child: EmojiPicker(
                        onEmojiSelected: ((category, emoji) {
                            messageController.text =
                                messageController.text + emoji.emoji;

                          if (!isShowSendButton) {
                            setState(() {
                              isShowSendButton = true;
                            });
                          }
                        }),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ]);
        },
      ),
    );
  }

  Message buildMessage() {
    final timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    if (messageReply != null) {
      return Message(
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
      );
    } else {
      return Message(
          senderId: widget.senderUser.uid,
          receiverId: widget.receiverUser.uid,
          messageContent: messageController.text,
          type: MessageEnum.text,
          timeSent: timeSent,
          messageId: messageId,
          isSeen: false);
    }
  }

  TextFormField buildTextFormField(BuildContext buildContext) {
    return TextFormField(
      maxLines: 6,
      minLines: 1,
      onTap: () {
        BlocProvider.of<ManagingStateVariablesInChatScreenBloc>(buildContext)
            .add(NotShowKeyboardEmojiEvent());
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
          onPressed: () => toggleEmojiKeyboardContainer(buildContext),
          icon: Icon(
            Icons.emoji_emotions,
            color: Theme.of(context).iconTheme.color,
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
                      builder: (context) => CameraScreen(
                            receiverUser: widget.receiverUser,
                            senderUser: widget.senderUser,
                          )));
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).iconTheme.color,
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
                    builder: (builder) => BottomSheetWidget(
                        context: context,
                        senderUser: widget.senderUser,
                        receiverUser: widget.receiverUser),
                  );
                },
                icon: Icon(
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

  void hideEmojiContainer(BuildContext buildContext) {
    BlocProvider.of<ManagingStateVariablesInChatScreenBloc>(buildContext)
        .add(NotShowKeyboardEmojiEvent());
  }

  void showEmojiContainer(BuildContext buildContext) {
    BlocProvider.of<ManagingStateVariablesInChatScreenBloc>(buildContext)
        .add(ShowKeyboardEmojiEvent());
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer(BuildContext buildContext) {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer(buildContext);
    } else {
      hideKeyboard();
      showEmojiContainer(buildContext);
    }
  }
}
