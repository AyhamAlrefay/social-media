import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import '../../../../injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildSafeArea(size, context),
    );
  }

  SafeArea buildSafeArea(Size size, BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Welcome to WhatsApp ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 33,
                  color: Colors.green),
            ),
            SizedBox(
              height: size.height / 12,
            ),
            Image.asset(
              'assets/images/img.png',
              height: 300,
              width: 300,
              color: Colors.green,
            ),
            SizedBox(height: size.height / 12),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(size.width * 0.5, 50),
                ),
                onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BlocProvider<SignInWithPhoneNumberBloc>(
                    create: (_)=>di.sl<SignInWithPhoneNumberBloc>(),child:const LoginScreen() ,)));
                },
                child: const Text('AGREE AND CONTINUE'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
