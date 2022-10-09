import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/widgets/snak_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'user_information_screen.dart';
import '../../../../injection_container.dart' as di;
import '../bloc/save_user_data/save_user_data_bloc.dart';
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;

   OtpScreen({Key? key, required this.verificationId}) : super(key: key);

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
           BlocConsumer<SignInWithPhoneNumberBloc,SignInWithPhoneNumberState>(
             listener: (context,state){
               if(state is SuccessVerifyOtp)
               {
                 BlocProvider<SaveUserDataBloc>(create: (_)=>di.sl<SaveUserDataBloc>());
                 Navigator.pushNamedAndRemoveUntil(
                     context, UserInformationScreen.routeName, (route) => false);
               }
               else if (state is LoadingVerifyOtp) {
                 const  LoadingWidget();
               }

             },
                builder: (BuildContext context, state) {

                  if(state is ErrorVerifyOtp){
                  showSnackBar(context: context, content: state.message);
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

              ),
          ],
        ),
      ),
    );
  }
}
