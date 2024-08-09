import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';

class PopularConstructorCard extends StatelessWidget {
  final String name;
  final String image;
  final String totalProjects;
  const PopularConstructorCard({
    super.key,
    required this.size,
    required this.name,
    required this.image,
    required this.totalProjects,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.1,
        width: size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade600,
              radius: 31,
              child:
                  CircleAvatar(radius: 30, backgroundImage: AssetImage(image)),
            ),
            SizedBox(
              width: size.height * 0.15,
              child: Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                name,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(
              width: size.height * 0.15,
              child: Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                "$totalProjects Total Projects",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: subTitleColor, fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
