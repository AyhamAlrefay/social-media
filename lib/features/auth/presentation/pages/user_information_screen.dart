import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat/presentation/bloc/get_contacts_user/get_contacts_user_bloc.dart';
import '../bloc/save_user_data/save_user_data_bloc.dart';
import '../../../../mobile_chat_screen.dart';
import 'package:whatsapp/injection_container.dart' as di;

class UserInformationScreen extends StatefulWidget {
  static const String routeName = '/user-information-screen';

  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 64,
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        var ad = buildAlertDialog(context);
                        showDialog(context: context, builder: (_) => ad);
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  BlocConsumer<SaveUserDataBloc, SaveUserDataState>(
                      builder: (BuildContext context, state) {
                    return IconButton(
                      onPressed: saveUserData,
                      icon: const Icon(
                        Icons.done,
                      ),
                    );
                  }, listener: (BuildContext context, state) {
                    if (state is SaveUserDataStateLoading) {
                      const LoadingWidget();
                    } else if (state is SaveUserDataStateSuccess) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BlocProvider<GetContactsUserBloc>(
                                create: (_) => di.sl<GetContactsUserBloc>()
                                  ..add(GetContactsUser()),
                                child: const MobileChatScreen(),
                              )));
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("chose photo from :"),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Divider(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              child: ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  selectImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              child: ListTile(
                leading: const Icon(Icons.add_a_photo),
                title: const Text("Camera"),
                onTap: () {
                  selectImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectImage(ImageSource src) async {
    final pickedFile = await ImagePicker().pickImage(source: src);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
    return image;
  }

  void saveUserData() {
    BlocProvider.of<SaveUserDataBloc>(context).add(
        SaveUserData(name: nameController.text.trim(), profilePic: image!));
  }
}
