import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/color.dart';

class OTPBox extends StatelessWidget {
  final TextEditingController? controller;
  const OTPBox({
    super.key,
    required this.size,
    this.controller,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width * 0.13,
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 5.0, 8.0),
        child: TextFormField(
          controller: controller,
          maxLength: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
