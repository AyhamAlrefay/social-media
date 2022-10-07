import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/theme/colors.dart';
import 'package:whatsapp/core/widgets/loading_widget.dart';
import 'package:whatsapp/features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'package:whatsapp/features/auth/presentation/pages/user_information_screen.dart';
import 'package:whatsapp/injection_container.dart' as di;
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  void verifyOTP({required BuildContext context, required String userOTP}) {
    BlocProvider.of<SignInWithPhoneNumberBloc>(context).add(VerifyOtpEvent(
        context: context, userOTP: userOTP, verificationId: verificationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            BlocProvider<SignInWithPhoneNumberBloc>(
              create: (_) => di.sl<SignInWithPhoneNumberBloc>(),
              child: BlocConsumer<SignInWithPhoneNumberBloc,SignInWithPhoneNumberState>(
                builder: (BuildContext context, state) {
                  if (state is LoadingVerifyOtp) {
                    return LoadingWidget();
                  }
                  return TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: '- - - - - -',
                        hintStyle: TextStyle(fontSize: 30)),
                    onChanged: (value) {
                      if (value.length == 6) {
                        verifyOTP(context: context, userOTP: value.trim());
                      }
                    },
                  );
                },
                listener: (BuildContext context, Object? state) {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
