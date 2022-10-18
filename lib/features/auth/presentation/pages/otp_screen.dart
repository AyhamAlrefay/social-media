import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/widgets/snak_bar.dart';
import '../../../../core/strings/string_public.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'user_information_screen.dart';
import '../../../../injection_container.dart' as di;
import '../bloc/save_user_data/save_user_data_bloc.dart';
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';

  const OtpScreen({Key? key}) : super(key: key);

  void verifyOTP({required BuildContext context, required String userOTP}) {
    BlocProvider.of<SignInWithPhoneNumberBloc>(context)
        .add(VerifyOtpEvent(userOTP: userOTP));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APPBAR_OTP_SCREEN),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              WE_SENT_A_SMS,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocConsumer<SignInWithPhoneNumberBloc, SignInWithPhoneNumberState>(
              listener: (context, state) {
                if (state is SuccessVerifyOtp) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<SaveUserDataBloc>(
                          create: (_) => di.sl<SaveUserDataBloc>(),
                          child: const UserInformationScreen(),
                        ),
                      ),
                      (route) => false);
                } else if (state is LoadingVerifyOtp) {
                  const LoadingWidget();
                }
              },
              builder: (BuildContext context, state) {
                if (state is ErrorVerifyOtp) {
                  showSnackBar(context: context, content: state.message);
                }
                return TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                   cursorColor: Theme.of(context).primaryColor,
                   style: Theme.of(context).textTheme.displayMedium,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '- - - - - -',
                      hintStyle: TextStyle(fontSize: 30)),
                  onChanged: (value) {
                    if (value.length == 6) {
                      verifyOTP(context: context, userOTP: value.trim());
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
