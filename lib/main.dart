
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/route.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/chat/presentation/bloc/get_message_user/get_message_user_bloc.dart';
import 'package:whatsapp/mobile_chat_screen.dart';
import 'features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'features/auth/presentation/bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import 'firebase_options.dart';
import 'package:whatsapp/features/auth/presentation/pages/splash_screen.dart';
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
    return MultiBlocProvider(providers: [
      BlocProvider<SignInWithPhoneNumberBloc>(
          create: (_)=>di.sl<SignInWithPhoneNumberBloc>()),
      BlocProvider<SaveUserDataBloc>(create: (_)=>di.sl<SaveUserDataBloc>()..add(GetUserData())),
      BlocProvider<GetMessageUserBloc>(create: (_)=>di.sl<GetMessageUserBloc>()),
    ], child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: BlocConsumer<SaveUserDataBloc,SaveUserDataState>(
        builder: (BuildContext context,state){
          if(state is GetUserDataStateLoading)
            {
              return const LoadingWidget();
            }
         else if(state is GetUserDataStateSuccess) {
           print(state.user.name);
           print(state.user.phoneNumber);
            return const MobileChatScreen();
          }
           else if(state is GetUserDataStateError) {
            return const SplashScreen();
          }
           return const SplashScreen();
        },
        listener: (BuildContext context,state){},
      ),
    ),);
  }
}

