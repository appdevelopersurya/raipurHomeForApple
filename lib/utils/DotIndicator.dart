import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 8,
      width: isActive ? 25 : 15,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white12,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      duration: const Duration(microseconds: 300),
    );
  }
}
