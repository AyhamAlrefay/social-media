import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp/core/widgets/error_widget.dart';
import 'package:whatsapp/features/auth/presentation/pages/login_screen.dart';
import 'package:whatsapp/features/auth/presentation/pages/otp_screen.dart';
import 'package:whatsapp/features/auth/presentation/pages/user_information_screen.dart';
import 'package:whatsapp/features/mobile_chat_screen/presentation/pages/chat_screen.dart';
import 'package:whatsapp/injection_container.dart' as di;
import 'package:whatsapp/mobile_chat_screen.dart';
import '../features/mobile_chat_screen/presentation/pages/calls.dart';
import '../features/mobile_chat_screen/presentation/pages/chats.dart';
import '../features/mobile_chat_screen/presentation/pages/status.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MobileChatScreen.routeName:
      return MaterialPageRoute(builder:(context)=>MobileChatScreen());
    case ChatUser.routeName:
      final contactinformation=settings.arguments as Contact?;
      return MaterialPageRoute(builder: (context)=>ChatUser(contactInformation:contactinformation));
    case Chats.routeName:
      return MaterialPageRoute(builder: (context)=>Chats());
    case Calls.routeName:
     return MaterialPageRoute(builder: (context)=>Calls());
    case Status.routeName:
      return MaterialPageRoute(builder: (context)=>Status());
    case OtpScreen.routeName:
      final verificationId=settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OtpScreen(
        verificationId: verificationId,
      ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context)=>const UserInformationScreen());
    case LoginScreen.routeName:return MaterialPageRoute(builder: (context)=> LoginScreen(),);
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
