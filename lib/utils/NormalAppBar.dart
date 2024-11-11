import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:provider/provider.dart';

import '../repository/getImageFromUser.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NormalAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
          // decoration: BoxDecoration(gradient: defaultGradient3),
          ),
      // backgroundColor: secondaryColor,
      elevation: 1,
      centerTitle: true,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: borderColor)),
          child: InkWell(
            onTap: () {
              context.read<GetImageFromUser>().removeImage();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  // Implement the preferredSize getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
