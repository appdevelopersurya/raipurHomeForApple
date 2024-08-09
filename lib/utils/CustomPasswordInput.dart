import 'package:flutter/material.dart';

import '../constant/color.dart';

class CustomPasswordInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isObscure;
  final IconData icon;
  const CustomPasswordInput({
    super.key, this.controller, required this.hintText, required this.isObscure, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x00FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isObscure,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelMedium,
          maxLength: 8,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(top: 15),
            hintStyle:
                Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: hintColor,
                    ),
            prefixIcon: Icon(
              icon,
              color: hintColor,
              size: 20,
            ),
            suffixIcon: isObscure ?  Icon(
              Icons.visibility,
              color: hintColor,
              size: 20,
            ) : Icon(
              Icons.visibility_off,
              color: hintColor,
              size: 20,
            ),
          ),
        ));
  }
}