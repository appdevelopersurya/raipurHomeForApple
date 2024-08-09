import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../constant/appText.dart';
import '../constant/color.dart';

class PopularPropertyCard extends StatelessWidget {
  final String image;
  final String propertyName;
  final String price;
  final String Sqft;
  final String bedrooms;
  final String bathrooms;
  const PopularPropertyCard({
    super.key,
    required this.size,
    required this.propertyName,
    required this.price,
    required this.Sqft,
    required this.bedrooms,
    required this.bathrooms,
    required this.image,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: size.height * 0.14,
                  width: size.height * 0.14,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      propertyName,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w600, color: textColor2),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "${AppText.rupeeSymbol} $price",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor2),
                            children: [
                          TextSpan(
                            text: "/mo",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: textColor2,
                                ),
                          ),
                        ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/bedroom.svg",
                              height: 18,
                              width: 18,
                            ),
                            const Gap(2),
                            Text(
                              bedrooms,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            )
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/bathtub.svg",
                              height: 18,
                              width: 18,
                            ),
                            const Gap(2),
                            Text(
                              bathrooms,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/areaSquare.svg",
                              height: 16,
                              width: 16,
                            ),
                            const Gap(2),
                            Text(
                              Sqft,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                            Text(
                              " sqft",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 15,
                  child: SvgPicture.asset(
                    "assets/svg/heartOutline.svg",
                    height: 18,
                    width: 18,
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: SvgPicture.asset(
              //     "assets/svg/heartOutline.svg",
              //     height: 18,
              //     width: 18,
              //   ),
              // )
            ],
          )),
    );
  }
}

class PopularPropertyCardForAll extends StatelessWidget {
  final String image;
  final String propertyName;
  final String price;
  final String Sqft;
  final String bedrooms;
  final String bathrooms;
  const PopularPropertyCardForAll({
    super.key,
    required this.size,
    required this.propertyName,
    required this.price,
    required this.Sqft,
    required this.bedrooms,
    required this.bathrooms,
    required this.image,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: size.height * 0.14,
                  width: size.height * 0.14,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      propertyName,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w600, color: textColor2),
                    ),
                    const Gap(25),
                    RichText(
                        text: TextSpan(
                            text: "${AppText.rupeeSymbol} $price",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor2),
                            children: [
                          TextSpan(
                            text: "/mo",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: textColor2,
                                ),
                          ),
                        ])),
                    const Gap(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/bedroom.svg",
                              height: 18,
                              width: 18,
                            ),
                            const Gap(2),
                            Text(
                              bedrooms,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            )
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/bathtub.svg",
                              height: 18,
                              width: 18,
                            ),
                            const Gap(2),
                            Text(
                              bathrooms,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/areaSquare.svg",
                              height: 16,
                              width: 16,
                            ),
                            const Gap(2),
                            Text(
                              Sqft,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                            Text(
                              " sqft",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: textColor2,
                                  ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 15,
                  child: SvgPicture.asset(
                    "assets/svg/heartOutline.svg",
                    height: 18,
                    width: 18,
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: SvgPicture.asset(
              //     "assets/svg/heartOutline.svg",
              //     height: 18,
              //     width: 18,
              //   ),
              // )
            ],
          )),
    );
  }
}
