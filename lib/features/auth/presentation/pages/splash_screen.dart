import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/strings/string_public.dart';
import '../../../../mobile_chat_screen.dart';
import 'landing_screen.dart';
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
            builder: (BuildContext context) =>const MobileChatScreen(),
            )
        );
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
          children:  [
           const Image(
              image: AssetImage(IMAGE_WHATSAPP),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              WHATSAPP,
              style: Theme.of(context).textTheme.displayLarge,
            ),

          ],
        ),
      ),
    );
  }
}
