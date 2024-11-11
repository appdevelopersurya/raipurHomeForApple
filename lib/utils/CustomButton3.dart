import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';

class CustomButton4 extends StatelessWidget {
  final String label;
  final Widget? widget;
  final String featuredType;
  final String currentType;
  final VoidCallback? onTap;

  const CustomButton4({
    super.key,
    this.label = "Button",
    this.widget,
    this.featuredType = "",
    this.currentType = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentType == featuredType;

    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
          gradient: isActive
              ? defaultGradient3
              : const LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget ?? const Offstage(),
              widget == null ? const Offstage() : const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: isActive ? textDarkColor : textColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
