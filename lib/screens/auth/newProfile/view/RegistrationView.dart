import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/CustomTextInput.dart';
import 'package:gap/gap.dart';

import '../../../../constant/color.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/registerTopImg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "Enter Your Registration Details",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: textColor2),
                      children: [
                        TextSpan(
                            text:
                                "\nSimply provide your details and get ready to explore a world of opportunities for your new home!",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: textColor3))
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  CustomTextInput(
                      hintText: "Enter your name",
                      keyboardType: TextInputType.name,
                      icon: Icons.person,
                      readOnly: false),
                  Gap(size.width * 0.020),
                  CustomTextInput(
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                      readOnly: false),
                  Gap(size.width * 0.020),
                  CustomTextInput(
                      hintText: "Enter your mobile number",
                      keyboardType: TextInputType.number,
                      icon: Icons.call,
                      readOnly: true),
                  Gap(size.width * 0.020),
                  CustomTextInput(
                      hintText: "Enter your complete area",
                      keyboardType: TextInputType.number,
                      icon: Icons.call,
                      readOnly: true),
                  Gap(size.width * 0.020),
                  Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: borderColor),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextFormField(
                        // controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 2,
                        style: Theme.of(context).textTheme.labelSmall,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your age",
                          counterText: "",
                          hintStyle:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: hintColor,
                                  ),
                          prefixIcon: const Icon(
                            Icons.account_box_rounded,
                            size: 20,
                          ),
                        ),
                      )),
                  Gap(size.width * 0.040),
                  const CustomButton(title: "Submit"),
                ],
              ),
            ),
          ]),
    );
  }
}
