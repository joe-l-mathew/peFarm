import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../functions/show_snackbar.dart';
import '../home/home_screen.dart';
import '../widgets/loading_button_widget.dart';
import '../widgets/text_widget.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.isFailed) {
                showSnackbar(context, "Invalid OTP");
              }
              // ignore: todo
              // TODO: implement listener
            },
            child: SizedBox(
              height: height * 0.1,
            ),
          ),
          const TextWidget(text: "VERIFICATION", fontSize: 20),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter the 6 Digit Code sent to\n+91 ${context.watch<AuthBloc>().state.phoneNumber}",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.isLoginCompleted) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => const HomeScreen()));
                }
              },
              child: Pinput(
                senderPhoneNumber: context.watch<AuthBloc>().state.phoneNumber,
                autofocus: true,
                disabledPinTheme: PinTheme(
                    decoration: BoxDecoration(color: Colors.grey[600])),
                length: 6,
                controller: otpController,
                onCompleted: (otp) {
                  otpController.text = otp;
                  context.read<AuthBloc>().add(SubmitOtp(otp));
                },
              ),
            ),
          )
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return LoadingButtonWidget(
              text: "Submit OTP",
              loadingText: "Loading",
              isLoading: state.isLoading,
              onPressed: () {});
        },
      ),
    );
  }
}
