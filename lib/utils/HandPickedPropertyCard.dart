import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/constant/appText.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';

class HandPickedPropertyCard extends StatelessWidget {
  final String image;
  final String propertyName;
  final String locations;
  final String price;
  const HandPickedPropertyCard({
    super.key,
    required this.size,
    required this.image,
    required this.propertyName,
    required this.locations,
    required this.price,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: size.height * 0.4,
        width: size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              // image: AssetImage("assets/images/onBoardImage3.jpg")),
              image: AssetImage(image)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: size.height * 0.1,
            width: size.height * 0.3,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    propertyName,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: textColor2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/loc.svg",
                        height: 18,
                        width: 18,
                        color: subTitleColor,
                      ),
                      const Gap(5),
                      SizedBox(
                        width: size.height * 0.18,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          locations,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: subTitleColor,
                                  fontSize: 12.0),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Row(children: [
                    RichText(
                        text: TextSpan(
                            text: "${AppText.rupeeSymbol}$price/",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor2),
                            children: [
                          TextSpan(
                              text: "month",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                      color: subTitleColor)),
                        ]))
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HandPickedPropertyCardAll extends StatelessWidget {
  final String image;
  final String propertyName;
  final String locations;
  final String price;
  const HandPickedPropertyCardAll({
    super.key,
    required this.size,
    required this.image,
    required this.propertyName,
    required this.locations,
    required this.price,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              // image: AssetImage("assets/images/onBoardImage3.jpg")),
              image: AssetImage(image)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: size.height * 0.1,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    propertyName,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: textColor2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/loc.svg",
                        height: 18,
                        width: 18,
                        color: subTitleColor,
                      ),
                      const Gap(5),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          locations,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: subTitleColor,
                                  fontSize: 12.0),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Row(children: [
                    RichText(
                        text: TextSpan(
                            text: "${AppText.rupeeSymbol}$price/",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor2),
                            children: [
                          TextSpan(
                              text: "month",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                      color: subTitleColor)),
                        ]))
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
