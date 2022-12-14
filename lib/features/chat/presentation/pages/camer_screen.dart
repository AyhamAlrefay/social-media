import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/chat/presentation/widgets/chat_screen/video_view.dart';
import 'package:whatsapp/injection_container.dart' as di;
import '../../../../core/strings/string_public.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../bloc/send_messages_user/send_message_user_bloc.dart';
import '../widgets/chat_screen/icon_button.dart';
import 'camera_view.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final UserEntity receiverUser;
  final UserEntity senderUser;
   const CameraScreen({ Key? key,required this.receiverUser,required this.senderUser}) : super(key: key);

  @override
  CameraScreenState createState() =>CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildIconButton.buildIconButton(icon:  flash ? Icons.flash_on : Icons.flash_off, function: () {
                        setState(() {
                          flash != flash;
                        });
                        flash
                            ? _cameraController
                            .setFlashMode(FlashMode.torch)
                            : _cameraController.setFlashMode(FlashMode.off);
                      }),

                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecoring = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videopath =
                          await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecoring = false;
                          });
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (builder) => VideoViewPage(
                                    path: videopath.path,
                                  )));
                        },
                        onTap: () {
                          if (isRecoring==false) takePhoto(context);
                        },
                        child: isRecoring
                            ? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                            : const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              iscamerafront = iscamerafront;
                              transform = transform + pi;
                            });
                            int cameraPos = iscamerafront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    HOLD_FOR_VIDIO_TAP_FOR_PHOTO,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();

    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (builder) =>     BlocProvider<SendMessageUserBloc>(
                create: (_) => di.sl<SendMessageUserBloc>(),child:CameraViewPage(
              file:file,
              receiverUser: widget.receiverUser,
              senderUser:widget.senderUser ,
            )),));
  }
}