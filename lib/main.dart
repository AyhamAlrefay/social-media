import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/route.dart';
import 'features/auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import 'features/chat/presentation/bloc/get_contacts_user/get_contacts_user_bloc.dart';
import 'features/chat/presentation/pages/camer_screen.dart';
import 'features/chat/presentation/bloc/get_messages_user/get_message_user_bloc.dart';
import 'features/chat/presentation/bloc/send_messages_user/send_message_user_bloc.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        //
        BlocProvider<GetMessageUserBloc>(
            create: (_) => di.sl<GetMessageUserBloc>()),
        //
        BlocProvider<GetContactsUserBloc>(
            create: (_) => di.sl<GetContactsUserBloc>()..add(GetContactsUser())),
        //
        BlocProvider<SendMessageUserBloc>(
            create: (_) => di.sl<SendMessageUserBloc>()),
        //
        BlocProvider<GetUsersDataBloc>(
            create: (_) => di.sl<GetUsersDataBloc>()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:getThemeDataLight(context),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: const  SplashScreen(),
    ),);
  }
}

