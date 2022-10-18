import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:whatsapp/core/strings/string_public.dart';
import '../../../../../auth/domain/entities/user_entity.dart';
import '../../../pages/camer_screen.dart';
import '../../../pages/camera_view.dart';
import '../file.dart';
import 'icon_creation.dart';
class BottomSheetWidget extends StatelessWidget {
  final BuildContext context;
  final UserEntity senderUser;
  final UserEntity receiverUser;
  const BottomSheetWidget({Key? key, required this.context, required this.senderUser, required this.receiverUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: const EdgeInsets.all(18.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(
                        Icons.insert_drive_file, Colors.indigo, "Document",
                            () async {
                          final result = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                          );
                          if (result == null) return;
                          final PlatformFile file = result.files.first;
                          openFiles(result.files);
                          openFile(file);
                          final newFile = await saveFilePermanently(file);
                        }),
                    const SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.camera_alt, Colors.pink, CAMERA, () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CameraScreen(
                            receiverUser:receiverUser,
                            senderUser: senderUser,
                          )));
                    }),
                    const SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.insert_photo, Colors.purple, GALLERY,
                            () async {
                          XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CameraViewPage(
                              file: image!,
                              receiverUser:receiverUser,
                              senderUser: senderUser,
                            ),
                          ),
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(Icons.headset, Colors.orange, AUDIO, () {}),
                    const SizedBox(
                      width: 40,
                    ),
                    iconCreation(
                        Icons.location_pin, Colors.teal, LOCATION, () {}),
                    const SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.person, Colors.blue, CONTACT, () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  static void openFiles(List<PlatformFile> files) {
    FilePage(files: files, onOpendFile: openFile);
  }

  static void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}


