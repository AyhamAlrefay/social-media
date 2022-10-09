
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/route.dart';
import 'mobile_chat_screen.dart';
import 'features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'features/auth/presentation/bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import 'features/chat/presentation/bloc/get_messages_user/get_message_user_bloc.dart';
import 'features/chat/presentation/bloc/send_messages_user/send_message_user_bloc.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: const  SplashScreen(),
    );
  }
}

