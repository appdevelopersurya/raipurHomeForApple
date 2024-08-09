import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constant/color.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool readOnly;
  const CustomTextInput({
    super.key,
    this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: readOnly == true ? Colors.grey.shade200 : null,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelSmall,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: hintColor,
                ),
            prefixIcon: Icon(
              icon,
              size: 20,
            ),
          ),
        ));
  }
}

class CustomTextInput2 extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool readOnly;
  const CustomTextInput2({
    super.key,
    this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: readOnly == true ? Colors.grey.shade200 : Colors.white,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelSmall,
            readOnly: readOnly,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: hintColor,
                  ),
            ),
          ),
        ));
  }
}

class CustomTextInputForSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final bool? isEnableVoice;
  const CustomTextInputForSearch({
    super.key,
    this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    required this.readOnly,
    this.onTap,
    this.isEnableVoice,
    this.onTapUp,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  onSubmitted: (value) {
                    if (onTap != null) onTap!();
                  },
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelSmall,
                  readOnly: readOnly,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: hintColor),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.search,
                color: textColor2,
              ),
            ),
            const Gap(10.0)
          ],
        ));
  }
}

class CustomTextInputForSearchHome extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? icon;
  final VoidCallback? onTapSearch;
  final VoidCallback? onTapLocation;
  final VoidCallback? onTapVoice;
  final VoidCallback? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final bool? isEnableVoice;
  const CustomTextInputForSearchHome({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.icon,
    this.onTapSearch,
    this.onTapLocation,
    this.onTapVoice,
    this.isEnableVoice,
    this.onTapUp,
    this.onTapDown,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.left,
                  onTap: onTap,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: hintColor),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: onTapSearch,
                child: Icon(
                  Icons.search,
                  color: accentColor,
                )),
            const Gap(10.0),
            GestureDetector(
                onTap: onTapLocation,
                child: Icon(
                  Icons.my_location,
                  color: accentColor,
                )),
            const Gap(10.0),
            GestureDetector(
                onTap: onTapVoice,
                child: AvatarGlow(
                    animate: isEnableVoice == false ? false : true,
                    glowColor:
                        isEnableVoice == false ? Colors.white : textColor3,
                    child: Icon(
                      Icons.mic,
                      color: accentColor,
                    ))),
            const Gap(10.0)
          ],
        ));
  }
}
