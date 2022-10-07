import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/core/theme/colors.dart';
import 'dart:io';

import 'package:whatsapp/features/mobile_chat_screen/presentation/widgets/chat_screen/file.dart';
class BottomChatField extends StatefulWidget {
  const BottomChatField({Key? key}) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isShowSendButton = true;
  TextEditingController messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

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
    return  Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextFormField(
                      maxLines: null,
                      onTap: (){
                       setState(() {
                         isShowEmojiContainer=false;
                       });
                      },

                      autofocus: true,
                      focusNode: focusNode,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message!',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: backgroundColor,
                        prefixIcon: IconButton(
                          onPressed: toggleEmojiKeyboardContainer,
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        suffixIcon: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: ()async{
                                  showKeyboard();
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all( Radius.circular(1000.0))),
                                    backgroundColor: Colors.black.withOpacity(0),
                                    isScrollControlled: true,
                                    anchorPoint: Offset(5,10),
                                    constraints:BoxConstraints(
                                      maxHeight: 300,
                                    ) ,
                                    elevation: 20,
                                    enableDrag: true,
                                    context: context,

                                      builder: (builder)=>bottomSheet(),
                                  );

                                },
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
                  )),
              Padding(
                padding:const EdgeInsets.only(
                  bottom: 8,
                  right: 2,
                  left: 2,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                      backgroundColor: backgroundColor,
                      radius: 25,
                      child: Icon(
                        isShowSendButton ? Icons.send : Icons.mic,
                        color: Colors.yellowAccent,
                      )),
                ),
              ),
            ],
          ),
          isShowEmojiContainer
              ?  ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height*0.35,
              ),
              child: EmojiPicker(
                onEmojiSelected: ((category, emoji) {
                  setState(() {
                    messageController.text =
                        messageController.text + emoji.emoji;
                    print(messageController.text);
                  });

                  if (!isShowSendButton) {
                    setState(() {
                      isShowSendButton = true;
                      print(messageController.text);
                    });
                  }
                }),

              ),
            )
              : const SizedBox(
          ),
        ],
      );

  }
  Widget bottomSheet() {
    return Padding( padding: MediaQuery.of(context).viewInsets,
    child: Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document",()async{
                     final result=await FilePicker.platform.pickFiles(allowMultiple: true,);
                     if(result==null)
                       return;
                     final PlatformFile file=result.files.first;
                     openFiles(result.files);
                     openFile(file);
                    final newFile= await saveFilePermanently(file);
                  }),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera",(){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",(){}),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio",(){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location",(){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact",(){}),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text,VoidCallback function) {
    return InkWell(
      onTap: function,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }  Future<File>saveFilePermanently(PlatformFile file)async{
    final appStorage =await getApplicationDocumentsDirectory();
    final newFile=File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }
  void openFiles(List<PlatformFile>files){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilePage(files:files,onOpendFile:openFile),));
  }
  void openFile(PlatformFile file){
  OpenFile.open(file.path);
  }
}
