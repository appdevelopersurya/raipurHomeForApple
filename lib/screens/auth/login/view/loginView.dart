import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/SentOtpResponseModel.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/screens/auth/login/viewModel/loginViewController.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => exit(1),
      child: Scaffold(
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
                    image: AssetImage('assets/images/loginTopImg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FadeIn(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                        text: "Welcome! Raipur Homes",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: textColor2),
                        children: [
                          TextSpan(
                              text:
                                  "\nExplore Raipur Homes! Log in using your mobile number here",
                              // "\nDiscover Raipur Homes Login with your mobile number here",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: textColor3))
                        ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    child: Text(
                      textAlign: TextAlign.left,
                      "Enter mobile number",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  FadeInRight(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IntlPhoneField(
                        controller: _mobileController,
                        pickerDialogStyle: PickerDialogStyle(
                            countryNameStyle:
                                Theme.of(context).textTheme.labelSmall,
                            countryCodeStyle:
                                Theme.of(context).textTheme.labelSmall,
                            searchFieldInputDecoration: InputDecoration(
                                hintText: "Search Country",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: hintColor))),
                        autovalidateMode: AutovalidateMode.disabled,
                        style: Theme.of(context).textTheme.labelSmall,
                        initialCountryCode: 'IN',
                        initialValue: '+91',
                        dropdownTextStyle:
                            Theme.of(context).textTheme.labelSmall,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                          hintText: "Enter Mobile Number",
                          // focusColor: Colors.grey.shade300,
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                  Gap(size.height * 0.030),
                  FadeInUp(
                    child: CustomButton(
                      title: "Continue",
                      onTap: () {
                        if (_mobileController.text.isEmpty) {
                          Utils.snackBar("Please enter mobile number", context,
                              warningColor);
                        } else if (_mobileController.text.length > 10) {
                          Utils.snackBar("Please enter valid mobile number",
                              context, warningColor);
                        } else {
                          final loginController =
                              context.read<LoginViewController>();
                          var body = {
                            "number": _mobileController.text.toString(),
                          };
                          customFutureLoader(
                            context: context,
                            future: () => loginController.loginWithNumber(body),
                          ).then(
                            (value) {
                              SentOtpResponseModel _setOtpModel =
                                  value.asValue?.value ??
                                      SentOtpResponseModel();
                              if (_setOtpModel.success == true) {
                                Utils.snackBar(
                                    "We Have sent otp on your entered mobile number",
                                    context,
                                    successColor);
                                box.write('access_token_raipurHomes',
                                    _setOtpModel.data?.token);
                                Navigator.pushNamed(
                                    context, AppRoutes.otpVerification,
                                    arguments: SentOtpResponseModel(
                                        data: Data(
                                      number: _mobileController.text.toString(),
                                      token:
                                          _setOtpModel.data?.token.toString(),
                                    )));
                              } else {
                                Utils.snackBar(
                                    "Please enter valid mobile number",
                                    context,
                                    errorColor);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
