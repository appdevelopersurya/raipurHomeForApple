import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/appText.dart';
import '../constant/color.dart';
import '../data/modal/OurProjectDetailsDataModel.dart';
import '../services/apis/app_url.dart';
import 'featuredPropertyCardShowOptions.dart';

class FeaturedPropertyCardForHome2 extends StatelessWidget {
  final CarouselController? carouselController;
  final String forSale;
  final String type;
  final String? subType;
  final String? floorType;
  final String price;
  final String? priceType;
  final String title;
  final String views;
  final String address;
  final String constructionSize;
  final String openSide;
  final String propertyFace;
  final String? propertyInterior;
  final String? flatType;
  final List<Getapiimages> imageList;
  final String? featureImage;
  final VoidCallback? onTap;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapShare;
  final bool isFavorite;
  final bool isLoading;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const FeaturedPropertyCardForHome2({
    super.key,
    required this.size,
    required this.forSale,
    required this.type,
    required this.price,
    this.priceType,
    required this.title,
    required this.address,
    required this.imageList,
    this.onPageChanged,
    this.carouselController,
    this.featureImage,
    this.onTap,
    this.onTapCall,
    this.onTapWhatsapp,
    this.onTapFavorite,
    this.onTapShare,
    required this.isFavorite,
    required this.views,
    required this.constructionSize,
    required this.openSide,
    required this.propertyFace,
    this.propertyInterior,
    this.flatType,
    required this.isLoading,
    this.subType,
    this.floorType,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool hasConstructionSize = constructionSize != null &&
        constructionSize != 0 &&
        !constructionSize.toString().contains("null");
    bool hasPropertyFace = propertyFace != null &&
        propertyFace != 0 &&
        !propertyFace.toString().contains("0") &&
        !propertyFace.toString().contains("null");
    bool hasOpenSide = openSide != null &&
        openSide != 0 &&
        !openSide.toString().contains("0") &&
        !openSide.toString().contains("null");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(width: 1, color: secondaryColor),
            boxShadow: [
              BoxShadow(
                color: textColor2.withOpacity(0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      height: size.width >= 640
                          ? size.height * 0.7
                          : size.height * 0.28,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: Colors.black),
                        // image: DecorationImage(
                        //     image:
                        //         const AssetImage("assets/images/onBoardImage1.jpg"),
                        //     fit: BoxFit.fill,
                        //     onError: (exception, stackTrace) {}),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: imageList.isEmpty
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    AppUrl.baseUrl + featureImage.toString(),
                                // featureImage.toString(),
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: size.width >= 640
                                          ? size.height * 0.7
                                          : size.height * 0.28,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.black),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                      "assets/png/rprNewLogo.png");
                                },
                              )
                            : CarouselSlider(
                                items: imageList
                                    .map(
                                      (item) => CachedNetworkImage(
                                        imageUrl: AppUrl.baseUrl +
                                            item.filePath.toString(),
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: size.width >= 640
                                                  ? size.height * 0.7
                                                  : size.height * 0.28,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.black),
                                            ),
                                          );
                                        },
                                        errorWidget:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              "assets/png/rprNewLogo.png");
                                        },
                                      ),
                                    )
                                    .toList(),
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  // aspectRatio: 16 / 9,
                                  height: size.width >= 640
                                      ? size.height * 0.8
                                      : size.height * 0.4,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  viewportFraction: 1,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // (views == "0" || views == "" || views.contains("null"))
                  //     ? const Offstage()
                  //     : Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             color: Colors.orange,
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 vertical: 5.0, horizontal: 8.0),
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const Icon(
                  //                   size: 18,
                  //                   Icons.visibility,
                  //                   color: Colors.white,
                  //                 ),
                  //                 const Gap(5.0),
                  //                 Text(
                  //                   views ?? "",
                  //                   style: Theme.of(context)
                  //                       .textTheme
                  //                       .labelSmall!
                  //                       .copyWith(color: Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: (forSale == 'Sell' || forSale == 'For Sell')
                          ? Colors.green.shade50
                          : (forSale == 'Rent' || forSale == 'For Rent')
                              ? textColor4.withOpacity(0.1)
                              : accentColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      child: Text(
                        forSale,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: (forSale == 'Sell' || forSale == 'For Sell')
                                ? Colors.green.shade800
                                : (forSale == 'Rent' || forSale == 'For Rent')
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
                          vertical: 5.0, horizontal: 8.0),
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RichText(
                        text: TextSpan(
                      text: price == ""
                          ? ""
                          : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol, decimalDigits: 0).format(int.parse(price))} ",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: secondaryColor),
                    )),
                  )
                ],
              ),
            ),
            const Gap(10.0),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  child: Text(
                      // "Ravathpura Property Group",
                      maxLines: 2,
                      title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            const Gap(15.0),
            FeaturedPropertyCardShowOptions(
              size: size,
              forSale: forSale,
              type: type,
              subType: subType,
              floorType: floorType,
              priceType: priceType,
              constructionSize: constructionSize,
              openSide: openSide,
              propertyFace: propertyFace,
              flatType: flatType,
              propertyInterior: propertyInterior,
            ),
            const Gap(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10.0),
                InkWell(
                  onTap: onTapCall,
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.call,
                      size: 24,
                      color: secondaryColor,
                    ),
                  ),
                ),
                const Gap(10.0),
                InkWell(
                  onTap: onTapWhatsapp,
                  child: CircleAvatar(
                    radius: 20,
                    child: SvgPicture.asset(
                      "assets/svg/whatsappSvg.svg",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const Gap(10.0),
                InkWell(
                  onTap: onTapShare,
                  child: const CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.share),
                  ),
                ),
                const Gap(10.0),
                isLoading == true
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
                    : InkWell(
                        onTap: onTapFavorite,
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: textColor4.withOpacity(0.1),
                            child: Icon(
                              isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 24,
                              color: textColor4,
                            )),
                      ),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class FeaturedPropertyCardSqaure extends StatelessWidget {
  final CarouselController? carouselController;
  final String forSale;
  final String type;
  final String? subType;
  final String? floorType;
  final String price;
  final String? priceType;
  final String title;
  final String views;
  final String address;
  final String constructionSize;
  final String openSide;
  final String propertyFace;
  final String? propertyInterior;
  final String? flatType;
  final List<Getapiimages> imageList;
  final String? featureImage;
  final VoidCallback? onTap;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapShare;
  final bool isFavorite;
  final bool isLoading;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const FeaturedPropertyCardSqaure({
    super.key,
    required this.size,
    required this.forSale,
    required this.type,
    required this.price,
    this.priceType,
    required this.title,
    required this.address,
    required this.imageList,
    this.onPageChanged,
    this.carouselController,
    this.featureImage,
    this.onTap,
    this.onTapCall,
    this.onTapWhatsapp,
    this.onTapFavorite,
    this.onTapShare,
    required this.isFavorite,
    required this.views,
    required this.constructionSize,
    required this.openSide,
    required this.propertyFace,
    this.propertyInterior,
    this.flatType,
    required this.isLoading,
    this.subType,
    this.floorType,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool hasConstructionSize = constructionSize != null &&
        constructionSize != 0 &&
        !constructionSize.toString().contains("null");
    bool hasPropertyFace = propertyFace != null &&
        propertyFace != 0 &&
        !propertyFace.toString().contains("0") &&
        !propertyFace.toString().contains("null");
    bool hasOpenSide = openSide != null &&
        openSide != 0 &&
        !openSide.toString().contains("0") &&
        !openSide.toString().contains("null");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 0.96,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(width: 1, color: secondaryColor),
            boxShadow: [
              BoxShadow(
                color: textColor2.withOpacity(0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      height: size.width >= 640
                          ? size.height * 0.7
                          : size.height * 0.28,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: Colors.black),
                        // image: DecorationImage(
                        //     image:
                        //         const AssetImage("assets/images/onBoardImage1.jpg"),
                        //     fit: BoxFit.fill,
                        //     onError: (exception, stackTrace) {}),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: imageList.isEmpty
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    AppUrl.baseUrl + featureImage.toString(),
                                // featureImage.toString(),
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: size.width >= 640
                                          ? size.height * 0.7
                                          : size.height * 0.28,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.black),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                      "assets/png/rprNewLogo.png");
                                },
                              )
                            : CarouselSlider(
                                items: imageList
                                    .map(
                                      (item) => CachedNetworkImage(
                                        imageUrl: AppUrl.baseUrl +
                                            item.filePath.toString(),
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: size.width >= 640
                                                  ? size.height * 0.7
                                                  : size.height * 0.28,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.black),
                                            ),
                                          );
                                        },
                                        errorWidget:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              "assets/png/rprNewLogo.png");
                                        },
                                      ),
                                    )
                                    .toList(),
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  // aspectRatio: 16 / 9,
                                  height: size.width >= 640
                                      ? size.height * 0.8
                                      : size.height * 0.4,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  viewportFraction: 1,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // (views == "0" || views == "" || views.contains("null"))
                  //     ? const Offstage()
                  //     : Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             color: Colors.orange,
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 vertical: 5.0, horizontal: 8.0),
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const Icon(
                  //                   size: 18,
                  //                   Icons.visibility,
                  //                   color: Colors.white,
                  //                 ),
                  //                 const Gap(5.0),
                  //                 Text(
                  //                   views ?? "",
                  //                   style: Theme.of(context)
                  //                       .textTheme
                  //                       .labelSmall!
                  //                       .copyWith(color: Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.96,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: (forSale == 'Sell' || forSale == 'For Sell')
                            ? Colors.green.shade50
                            : (forSale == 'Rent' || forSale == 'For Rent')
                                ? textColor4.withOpacity(0.1)
                                : accentColor.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        child: Text(
                          forSale,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: (forSale == 'Sell' ||
                                          forSale == 'For Sell')
                                      ? Colors.green.shade800
                                      : (forSale == 'Rent' ||
                                              forSale == 'For Rent')
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
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RichText(
                          text: TextSpan(
                        text: price == ""
                            ? ""
                            : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol, decimalDigits: 0).format(int.parse(price))} ",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: secondaryColor),
                      )),
                    )
                  ],
                ),
              ),
            ),
            const Gap(10.0),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  child: Text(
                      // "Ravathpura Property Group",
                      maxLines: 2,
                      title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            const Gap(15.0),
            FeaturedPropertyCardShowOptions(
              size: size,
              forSale: forSale,
              type: type,
              subType: subType,
              floorType: floorType,
              priceType: priceType,
              constructionSize: constructionSize,
              openSide: openSide,
              propertyFace: propertyFace,
              flatType: flatType,
              propertyInterior: propertyInterior,
            ),
            const Gap(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10.0),
                InkWell(
                  onTap: onTapCall,
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.call,
                      size: 24,
                      color: secondaryColor,
                    ),
                  ),
                ),
                const Gap(10.0),
                InkWell(
                  onTap: onTapWhatsapp,
                  child: CircleAvatar(
                    radius: 20,
                    child: SvgPicture.asset(
                      "assets/svg/whatsappSvg.svg",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const Gap(10.0),
                InkWell(
                  onTap: onTapShare,
                  child: const CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.share),
                  ),
                ),
                const Gap(10.0),
                isLoading == true
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
                    : InkWell(
                        onTap: onTapFavorite,
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: textColor4.withOpacity(0.1),
                            child: Icon(
                              isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 24,
                              color: textColor4,
                            )),
                      ),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
