import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  String title;
  String bgImage;
  VoidCallback? onTap;

  CardButton(
      {super.key, required this.title, required this.bgImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          // border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(bgImage)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Soft shadow color
              blurRadius: 3, // Soft blur
              offset: const Offset(0, 1), // Vertical shadow offset
            ),
          ],
        ),
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
