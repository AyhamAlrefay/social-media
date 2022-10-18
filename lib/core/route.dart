import 'package:flutter/material.dart';
import 'package:whatsapp/core/strings/string_public.dart';
import 'package:whatsapp/features/auth/domain/entities/user_entity.dart';
import 'widgets/error_widget.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/otp_screen.dart';
import '../features/auth/presentation/pages/user_information_screen.dart';
import '../mobile_chat_screen.dart';
import '../features/calls/presentation/pages/calls.dart';
import '../features/chat/presentation/pages/chat_user.dart';
import '../features/chat/presentation/pages/contacts.dart';
import '../features/groups/presentation/pages/groups.dart';
import '../features/status/presentation/pages/status.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MobileChatScreen.routeName:
      return MaterialPageRoute(builder:(context)=>MobileChatScreen());
    case ChatUser.routeName:
      final UserEntity sender=settings.arguments as UserEntity;
      final UserEntity receiver=settings.arguments as UserEntity;
      return MaterialPageRoute(builder: (context)=>ChatUser(receiver: receiver,sender: sender,));
    case Contacts.routeName:
      return MaterialPageRoute(builder: (context)=>const Contacts());
    case Groups.routeName:
      return MaterialPageRoute(builder: (context)=>const Groups());
    case Calls.routeName:
     return MaterialPageRoute(builder: (context)=>const Calls());
    case Status.routeName:
      return MaterialPageRoute(builder: (context)=>const Status());
    case OtpScreen.routeName:

      return MaterialPageRoute(builder: (context) => const OtpScreen());
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context)=>const UserInformationScreen());
    case LoginScreen.routeName:return MaterialPageRoute(builder: (context)=> LoginScreen(),);
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: ERROR_SCREEN),
        ),
      );
  }
}
