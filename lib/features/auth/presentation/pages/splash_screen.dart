import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../mobile_chat_screen.dart';
import '../../../chat/presentation/bloc/get_contacts_user/get_contacts_user_bloc.dart';
import 'landing_screen.dart';
import 'package:whatsapp/injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  static String routeName = '/SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(
        const Duration(seconds: 2),
        ()
    {
      if(FirebaseAuth.instance.currentUser !=null) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>BlocProvider<GetContactsUserBloc>(
              create: (_) => di.sl<GetContactsUserBloc>()..add(GetContactsUser()),
              child:const MobileChatScreen(),)
        ));
      }
     else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LandingScreen()));
      }

    }
    );

  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSafeArea(),
    );
  }

  SafeArea buildSafeArea() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/download (1).jpg'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'WhatsApp',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 30,
            ),
         
          ],
        ),
      ),
    );
  }
}
