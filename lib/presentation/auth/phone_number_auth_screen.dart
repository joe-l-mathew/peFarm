import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../constants/colors.dart';
import '../../functions/show_snackbar.dart';
import '../widgets/loading_button_widget.dart';
import '../widgets/text_widget.dart';
import 'otp_screen.dart';

class PhoneNumberAuthScreen extends StatelessWidget {
  PhoneNumberAuthScreen({super.key});
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              const Center(
                child: TextWidget(
                  text: "Login or Signup",
                  fontSize: 25,
                  color: LocalColorScheme.primary,
                ),
              ),
              // TextWidget(text: "Enter Phone Number", fontSize: 20),
              SizedBox(
                height: height * 0.1,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextWidget(text: "Enter Phone Number", fontSize: 12),
              ),

              TextFormField(
                autofocus: true,
                controller: _phoneNumberController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                    focusColor: LocalColorScheme.primary,
                    hoverColor: LocalColorScheme.primary,
                    hintText: "Enter Phone Number",
                    border: OutlineInputBorder(),
                    prefixText: "+ 91"),
                keyboardType: TextInputType.phone,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.verificationId != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => OtpScreen()));
              }
            },
            child: LoadingButtonWidget(
              text: "NEXT",
              loadingText: "Loading",
              isLoading: state.isLoading,
              onPressed: () {
                if (_phoneNumberController.text.length == 10) {
                  context.read<AuthBloc>().add(PhoneNumberLogin(
                      phoneNumber: _phoneNumberController.text,
                      context: context));
                } else {
                  showSnackbar(context, "Invalid Phone Number");
                }
              },
            ),
          );
        },
      ),
    );
  }
}
