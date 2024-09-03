import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/screens/auth/VerifyOTP/viewModal/OTPViewController.dart';
import 'package:fmraipuromes/screens/auth/login/viewModel/loginViewController.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/OTPBox.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../data/modal/SentOtpResponseModel.dart';

class VerifyOTPView extends StatefulWidget {
  final SentOtpResponseModel sentOtpResponseModel;

  const VerifyOTPView({super.key, required this.sentOtpResponseModel});

  @override
  State<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends State<VerifyOTPView> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();

  static const int _initialTime = 30;
  int _currentTime = _initialTime;
  int _attempts = 0;
  Timer? _timer;

  void _startTimer() {
    if (_attempts < 4) {
      setState(() {
        _currentTime = _initialTime;
        _attempts++;
      });

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_currentTime > 0) {
            _currentTime--;
          } else {
            _timer?.cancel();
          }
        });
      });
    }
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          FadeInDown(
            child: Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/gif/sli2.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FadeInLeft(
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "Verify Your Code",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: textColor2),
                      children: [
                        TextSpan(
                            text:
                                "\nWe've sent an OTP to your registered mobile number ${widget.sentOtpResponseModel.data?.number}. Please check and enter it here.",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: textColor3))
                      ]),
                ),
              ),
            ),
          ),
          FadeInRight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OTPBox(
                  size: size,
                  controller: _otpController1,
                ),
                OTPBox(
                  size: size,
                  controller: _otpController2,
                ),
                OTPBox(
                  size: size,
                  controller: _otpController3,
                ),
                OTPBox(
                  size: size,
                  controller: _otpController4,
                ),
                OTPBox(
                  size: size,
                  controller: _otpController5,
                ),
                OTPBox(
                  size: size,
                  controller: _otpController6,
                ),
              ],
            ),
          ),
          Gap(size.height * 0.040),
          if (_attempts <= 3)
            FadeInLeft(
              child: Text(
                textAlign: TextAlign.center,
                'Resend OTP in 00:$_currentTime sec',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          Gap(size.height * 0.040),
          FadeIn(
            child: Container(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Haven't received the OTP? ",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          final loginController =
                              context.read<LoginViewController>();
                          if (_currentTime == 0) {
                            if (_attempts < 4) {
                              _startTimer();
                              var body = {
                                "number":
                                    widget.sentOtpResponseModel.data?.number,
                                // Example number, replace with actual number
                              };
                              customFutureLoader(
                                context: context,
                                future: () =>
                                    loginController.loginWithNumber(body),
                              ).then(
                                (value) {
                                  SentOtpResponseModel _setOtpModel =
                                      value.asValue?.value ??
                                          SentOtpResponseModel();
                                  if (_setOtpModel.success == true) {
                                    box.write('access_token_raipurHomes',
                                        _setOtpModel.data?.token);
                                    Utils.snackBar(
                                        "The OTP has been successfully re-sent",
                                        context,
                                        Colors.green);
                                  }
                                },
                              );
                            } else {
                              Utils.toastMessage(
                                  "You have reached the maximum number of attempts.",
                                  errorColor);
                            }
                          }
                        },
                      text: 'Resend OTP',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _currentTime == 0 && _attempts < 4
                                ? Colors.blue
                                : Colors.grey,
                          ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Gap(size.height * 0.040),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: FadeInUp(
              child: CustomButton(
                title: "Continue",
                onTap: () {
                  if (_otpController1.text.isEmpty ||
                      _otpController2.text.isEmpty ||
                      _otpController3.text.isEmpty ||
                      _otpController4.text.isEmpty ||
                      _otpController5.text.isEmpty ||
                      _otpController6.text.isEmpty) {
                    Utils.snackBar(
                        "Please enter valid OTP", context, warningColor);
                  } else {
                    String OTP = _otpController1.text.toString() +
                        _otpController2.text.toString() +
                        _otpController3.text.toString() +
                        _otpController4.text.toString() +
                        _otpController5.text.toString() +
                        _otpController6.text.toString();

                    var body = {
                      "number":
                          "${widget.sentOtpResponseModel.data?.number.toString()}",
                      "user_otp": "${OTP.toString()}",
                      "token": "${box.read("access_token_raipurHomes")}",
                    };
                    print("otp body data = $body");
                    final verifyOTPController =
                        context.read<OTPViewController>();
                    customFutureLoader(
                        context: context,
                        future: () async =>
                            await verifyOTPController.verifyOtp(body)).then(
                      (value) {
                        SentOtpResponseModel _setOtpModel =
                            value.asValue?.value ?? SentOtpResponseModel();
                        if (_setOtpModel.success == true) {
                          Utils.toastMessage(
                              "You have logged in successfully", successColor);
                          print(
                              "Access token raipur home===> ${_setOtpModel.data?.token}");
                          box.write("is_logged_raipurHome", true);
                          GetStorageHelper.setdata(_setOtpModel);
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.homeMain, (route) => false);
                        } else {
                          Utils.snackBar(
                              "Please enter valid OTP", context, errorColor);
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
          const Gap(40.0),
          // if (_attempts > 3)
          //   Text(
          //     textAlign: TextAlign.center,
          //     'You have reached the maximum number of attempts.',
          //     style: Theme.of(context)
          //         .textTheme
          //         .labelSmall!
          //         .copyWith(color: errorColor),
          //   ),
        ],
      ),
    );
  }
}
