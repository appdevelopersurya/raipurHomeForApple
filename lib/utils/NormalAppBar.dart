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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFffffff),
              Color(0xFFf3ef66),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      // backgroundColor: secondaryColor,
      elevation: 1,
      centerTitle: true,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor2),
      ),
      leading: InkWell(
        onTap: () {
          context.read<GetImageFromUser>().removeImage();
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: textColor2,
        ),
      ),
    );
  }

  // Implement the preferredSize getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
