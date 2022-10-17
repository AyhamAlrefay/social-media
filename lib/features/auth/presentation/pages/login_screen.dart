import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/auth/presentation/pages/otp_screen.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import '../../../../core/widgets/snak_bar.dart';
import '../../../../injection_container.dart' as di;

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
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.zero,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        context: context,
        onSelect: (Country value) {
          setState(() {
            country = value;
          });
        });
  }

  void sendPhoneNumber() async {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      BlocProvider.of<SignInWithPhoneNumberBloc>(context).add(PhoneNumberEvent(
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
      appBar: AppBar(
        title: const Text('Enter your phone number'),
      ),
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
          Text(
            'WhatsApp will need to verify your phone number.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: pickCountry,
            child: Text(
              'Pick Country',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (country != null)
                Text(
                  '+${country!.phoneCode}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              const SizedBox(width: 10),
              SizedBox(
                width: size.width * 0.7,
                child: TextField(
                  style: Theme.of(context).textTheme.displayMedium,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'phone number',
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.6),
          SizedBox(
            width: 90,
            child: BlocConsumer<SignInWithPhoneNumberBloc,
                SignInWithPhoneNumberState>(
              listener: (BuildContext context, state) {
                if (state is SuccessSignInWithPhoneNumberState) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider<SignInWithPhoneNumberBloc>(
                      create: (_) => di.sl<SignInWithPhoneNumberBloc>(),
                      child: const OtpScreen(),
                    ),
                  ));
                } else if (state is LoadingSignInWithPhoneNumberState) {
                  const LoadingWidget();
                } else if (state is ErrorSignInWithPhoneNumberState) {
                  showSnackBar(context: context, content: state.error);
                }
              },
              builder: (BuildContext context, state) {
                return ElevatedButton(
                  onPressed: sendPhoneNumber,
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    'NEXT',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
