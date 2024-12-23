import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:gap/gap.dart';

import '../constant/color.dart';

class PopularLocation extends StatelessWidget {
  final String image;
  final String locationName;
  final String? propertyQty;

  const PopularLocation({
    super.key,
    required this.image,
    required this.locationName,
    this.propertyQty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,

          borderRadius: BorderRadius.circular(16.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 3,
          //     offset: const Offset(0, 2),
          //   )
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(width: 2, color: secondaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    width: 100,
                    height: 100,
                    imageUrl: AppUrl.baseUrl + image.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        "assets/png/rprNewLogo.png",
                        width: 100,
                        height: 100,
                      );
                    },
                  ),
                ),
              ),
              Text(
                locationName,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: textColor2, fontWeight: FontWeight.w600),
              ),
              // Text(
              //   "$propertyQty Properties",
              //   style: Theme.of(context).textTheme.labelSmall!.copyWith(
              //         color: subTitleColor,
              //         fontSize: 12.0,
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularLocationSquare extends StatelessWidget {
  final String image;
  final String locationName;
  final String? propertyQty;

  const PopularLocationSquare({
    super.key,
    required this.image,
    required this.locationName,
    this.propertyQty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image with Gradient Overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: AppUrl.baseUrl + image,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(
                  "assets/png/rprNewLogo.png",
                  width: 100,
                  height: 100,
                );
              },
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Location Name Text
          Positioned(
            right: 5,
            left: 5,
            bottom: 8,
            child: Text(
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              locationName,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
