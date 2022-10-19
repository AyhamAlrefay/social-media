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
import '../../bloc/send_messages_user/send_message_user_bloc.dart';
import '../../pages/camer_screen.dart';

class BottomChatField extends StatefulWidget {
  final UserEntity receiverUser;
  final UserEntity senderUser;
  static final ManagingStateVariablesInChatScreenBloc managingStateVariablesBloc3=ManagingStateVariablesInChatScreenBloc();
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
  MessageReply? messageReply;
  final ManagingStateVariablesInChatScreenBloc managingStateVariablesBloc1 =
  ManagingStateVariablesInChatScreenBloc();
  final ManagingStateVariablesInChatScreenBloc managingStateVariablesBloc2 =
  ManagingStateVariablesInChatScreenBloc();


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManagingStateVariablesInChatScreenBloc>(
      create: (buildContext) => di.sl<ManagingStateVariablesInChatScreenBloc>(),
      child: Builder(
        builder: (BuildContext buildContext) {
          return Column(children: [
            blocConsumerMessageReply(),
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
                      BottomChatField.managingStateVariablesBloc3
                          .add(DeleteMessageReplyEvent());
                      messageController.clear();
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(5, 96, 98, 1),
                      radius: 25,
                      child: blocBuilderSendMessage(),
                    ),
                  ),
                ),
              ],
            ),
            blocConsumerKeyboardEmoji(),
          ]);
        },
      ),
    );
  }

  BlocConsumer<ManagingStateVariablesInChatScreenBloc, ManagingStateVariablesInChatScreenState> blocConsumerKeyboardEmoji() {
    return BlocConsumer<ManagingStateVariablesInChatScreenBloc,
        ManagingStateVariablesInChatScreenState>(
        bloc: managingStateVariablesBloc1,
        listener: (context, state) {
          if (state is NotShowKeyboardEmojiState) {
            isShowEmojiContainer = state.isShowEmojiKeyboard;
          }
        },
        builder: (context, state) {
          if (state is ShowKeyboardEmojiState) {
            isShowEmojiContainer = state.isShowEmojiKeyboard;
            return buildConstrainedBox(context);
          } else {
            return const SizedBox();
          }
        });
  }

  BlocBuilder<ManagingStateVariablesInChatScreenBloc, ManagingStateVariablesInChatScreenState> blocBuilderSendMessage() {
    return BlocBuilder<ManagingStateVariablesInChatScreenBloc,
        ManagingStateVariablesInChatScreenState>(
        bloc: managingStateVariablesBloc2,
        builder: (context, state) {
          if (state is ShowSendButtonState) {
            isShowSendButton = state.showSendButton;
            return Icon(
              Icons.send,
              color: Theme.of(context).iconTheme.color,
            );
          } else if (state is NotShowSendButtonState) {
            isShowSendButton = state.notShowSendButton;
            return Icon(Icons.mic,
                color: Theme.of(context).iconTheme.color);
          }
          return const SizedBox();
        });
  }

  BlocConsumer<ManagingStateVariablesInChatScreenBloc, ManagingStateVariablesInChatScreenState> blocConsumerMessageReply() {
    return BlocConsumer<ManagingStateVariablesInChatScreenBloc, ManagingStateVariablesInChatScreenState>(
      bloc: BottomChatField.managingStateVariablesBloc3,
      listener: (context, state) {
        if (state is NotMessageReplyState) {
          messageReply = null;
        }
      },
      builder: (context, state) {
        if (state is ChangeMessageRelyToDataState) {
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
    );
  }

  ConstrainedBox buildConstrainedBox(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: EmojiPicker(
        onEmojiSelected: ((category, emoji) {
          messageController.text = messageController.text + emoji.emoji;

          if (!isShowSendButton) {
            managingStateVariablesBloc2.add(ShowSendButtonEvent());
          }
        }),
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
        managingStateVariablesBloc1.add(NotShowKeyboardEmojiEvent());
      },
      autofocus: true,
      focusNode: focusNode,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      controller: messageController,
      onChanged: (value) {
        if (value.isEmpty) {
          managingStateVariablesBloc2.add(NotShowSendButtonEvent());
        } else {
          managingStateVariablesBloc2.add(ShowSendButtonEvent());
        }
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
    managingStateVariablesBloc1.add(NotShowKeyboardEmojiEvent());
  }

  void showEmojiContainer(BuildContext buildContext) {
    managingStateVariablesBloc1.add(ShowKeyboardEmojiEvent());
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