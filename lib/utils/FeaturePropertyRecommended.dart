import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fmraipuromes/constant/appText.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class FeaturePropertyRecommended extends StatelessWidget {
  final String image;
  final String title;
  final String address;
  final String propertyType;
  final String type;
  final String price;
  final String priceType;
  final VoidCallback onTap;

  const FeaturePropertyRecommended({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.address,
    required this.type,
    required this.price,
    required this.priceType,
    required this.propertyType,
    required this.onTap,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      width: 150,
                      fit: BoxFit.cover,
                      imageUrl: image,
                      // "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg",
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/png/rprNewLogo.png"),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10.0),
                  SizedBox(
                    width: size.width * 0.44,
                    child: Text(title,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  const Gap(10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: subTitleColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Text(address,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith()),
                      ),
                    ],
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      propertyType == ""
                          ? const Offstage()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: (propertyType == 'Sell' ||
                                        propertyType == 'For Sell')
                                    ? Colors.green.shade50
                                    : (propertyType == 'Rent' ||
                                            propertyType == 'For Rent')
                                        ? textColor4.withOpacity(0.1)
                                        : accentColor.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                child: Text(
                                  propertyType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: (propertyType == 'Sell' ||
                                                  propertyType == 'For Sell')
                                              ? Colors.green.shade800
                                              : (propertyType == 'Rent' ||
                                                      propertyType ==
                                                          'For Rent')
                                                  ? textColor4.withOpacity(0.8)
                                                  : accentColor
                                                      .withOpacity(0.8),
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                      const Gap(10.0),
                      type == ""
                          ? const Offstage()
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.blue.shade50),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                child: Text(
                                  type,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(
                          text: NumberFormat.currency(
                                  locale: 'HI',
                                  symbol: AppText.rupeeSymbol,
                                  decimalDigits: 0)
                              .format(int.parse(price)),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: secondaryColor),
                        ))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String image;
  final String title;
  final String address;
  final String propertyType;
  final String type;
  final String price;
  final bool isFav;
  final bool isLoading;
  final VoidCallback? onTapFav;

  const FavoriteCard({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.address,
    required this.propertyType,
    required this.type,
    required this.price,
    this.onTapFav,
    required this.isFav,
    required this.isLoading,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 165,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: secondaryColor),
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    height: 165,
                    width: 120,
                    fit: BoxFit.fill,
                    imageUrl: image,
                    // "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg",
                    placeholder: (context, url) {
                      return const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.height * 0.15,
                    child: Text(
                      // "Montreal Quriqe Apartment",
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/loc.svg",
                        height: 18,
                        width: 18,
                        color: subTitleColor,
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          // "Near Currency Tower VIP Road Amlidih",
                          address,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: subTitleColor,
                                  fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: (propertyType == 'Sell' ||
                                  propertyType == 'For Sell')
                              ? Colors.green.shade50
                              : (propertyType == 'Rent' ||
                                      propertyType == 'For Rent')
                                  ? textColor4.withOpacity(0.1)
                                  : accentColor.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 8.0),
                          child: Text(
                            propertyType,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: (propertyType == 'Sell' ||
                                            propertyType == 'For Sell')
                                        ? Colors.green.shade800
                                        : (propertyType == 'Rent' ||
                                                propertyType == 'For Rent')
                                            ? textColor4.withOpacity(0.8)
                                            : accentColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Gap(10.0),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blue.shade50),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          child: Text(
                            type,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                    text: price == ""
                        ? ""
                        : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol, decimalDigits: 0).format(int.parse(price))} ",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: secondaryColor),
                  ))
                ],
              ),
            ),
            const Spacer(),
            isLoading == true
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: onTapFav,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          isFav == true
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 18,
                          color: isFav ? textColor4 : Colors.grey,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
