import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constant/color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: secondaryColor,
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: buttonTextColor),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const CustomButton2({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: secondaryColor,
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: buttonTextColor),
          ),
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback? onTap;
  const CustomButton3({
    super.key,
    required this.title,
    this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 12, 0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              leading,
              const Gap(10.0),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
