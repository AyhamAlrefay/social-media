import 'package:flutter/material.dart';
import 'package:whatsapp/core/strings/string_public.dart';
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
            Text(
              WELCOME_TO_WHATSAPP ,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: size.height / 12,
            ),
            Image.asset(
              IMAGE_WELCOME,
              height: 300,
              width: 300,
              color: Colors.green,
            ),
            SizedBox(height: size.height / 12),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                DESCRIPTION_WELCOME,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<SignInWithPhoneNumberBloc>(
                                create: (_) =>
                                    di.sl<SignInWithPhoneNumberBloc>(),
                                child: const LoginScreen(),
                              )));
                },
                child: const Text(TEXT_BTN),
              ),
            )
          ],
        ),
      ),
    );
  }
}
