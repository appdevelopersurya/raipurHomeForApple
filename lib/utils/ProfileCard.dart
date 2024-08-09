import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback? onTap;
  const ProfileCard({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: leading,
                )),
            const Gap(20),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              child: const Icon(size: 20, Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
