import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/snak_bar.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  Country? country;

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() async {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      BlocProvider.of<SignInWithPhoneNumberBloc>(context).add(PhoneNumberEvent(
          context: context,
          phoneNumber: '+${country!.phoneCode}$phoneNumber'.trim()));
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(size),
    );
  }

  SingleChildScrollView buildBody(Size size) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(18),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('WhatsApp will need to verify your phone number.'),
          const SizedBox(height: 10),
          TextButton(
            onPressed: pickCountry,
            child: const Text('Pick Country'),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (country != null) Text('+${country!.phoneCode}'),
              const SizedBox(width: 10),
              SizedBox(
                width: size.width * 0.7,
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'phone number',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.6),
          SizedBox(
            width: 90,
            child: BlocBuilder<SignInWithPhoneNumberBloc,
                SignInWithPhoneNumberState>(
              builder: (BuildContext context, state) {
                if (state is SuccessSignInWithPhoneNumberState) {
                  return CustomButton(
                    onPressed: sendPhoneNumber,
                    text: 'NEXT',
                  );
                }
                if (state is ErrorSignInWithPhoneNumberState) {
                  showSnackBar(context: context, content: state.error);
                }
                return const LoadingWidget();
              },
            ),
          ),
        ],
      ),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Enter your phone number'),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }
}
