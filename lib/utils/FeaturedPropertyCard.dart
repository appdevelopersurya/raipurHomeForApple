import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/constant/appText.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/featuredPropertyCardShowOptions.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedPropertyCardForHome extends StatelessWidget {
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

  const FeaturedPropertyCardForHome({
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
                  (views == "0" || views == "" || views.contains("null"))
                      ? const Offstage()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    size: 18,
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  const Gap(5.0),
                                  Text(
                                    views ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
            // (forSale == 'Sell' || forSale == 'For Sell')
            //     ? Center(
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             // Construction Size
            //             Visibility(
            //               visible: constructionSize != "null" &&
            //                   constructionSize != null &&
            //                   constructionSize != "" &&
            //                   constructionSize != "0",
            //               child: Row(
            //                 children: [
            //                   CircleAvatar(
            //                     radius: 16,
            //                     child: SvgPicture.asset(
            //                       "assets/svg/rSize.svg",
            //                       height: 18,
            //                       width: 18,
            //                       color: textColor6,
            //                     ),
            //                   ),
            //                   const Gap(5),
            //                   Text(
            //                     constructionSize ?? "",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelSmall!
            //                         .copyWith(color: textColor6),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             const Gap(10.0),
            //             // Property Face
            //             propertyFace == null ||
            //                     propertyFace == "" ||
            //                     propertyFace == "null" ||
            //                     propertyFace == "0"
            //                 ? const Offstage()
            //                 : (type == "Plot" || type == "plot")
            //                     ? (openSide.toString() != "0")
            //                         ? Row(
            //                             children: [
            //                               CircleAvatar(
            //                                 radius: 16,
            //                                 backgroundColor:
            //                                     Colors.blueGrey.shade50,
            //                                 child: Icon(
            //                                   Icons.maps_home_work_outlined,
            //                                   size: 18,
            //                                   color: textColor6,
            //                                 ),
            //                               ),
            //                               const SizedBox(width: 5),
            //                               Text(
            //                                 openSide.toString(),
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .labelSmall!
            //                                     .copyWith(color: textColor6),
            //                               ),
            //                             ],
            //                           )
            //                         : const Offstage()
            //                     : (type == "House" || type == "house")
            //                         ? (floorType != null &&
            //                                 floorType.toString() != "0")
            //                             ? Row(
            //                                 children: [
            //                                   CircleAvatar(
            //                                     radius: 16,
            //                                     backgroundColor:
            //                                         Colors.blueGrey.shade50,
            //                                     child: Icon(
            //                                       Icons.maps_home_work_outlined,
            //                                       size: 18,
            //                                       color: textColor6,
            //                                     ),
            //                                   ),
            //                                   const SizedBox(width: 5),
            //                                   Text(
            //                                     floorType.toString(),
            //                                     style: Theme.of(context)
            //                                         .textTheme
            //                                         .labelSmall!
            //                                         .copyWith(
            //                                             color: textColor6),
            //                                   ),
            //                                 ],
            //                               )
            //                             : const Offstage()
            //                         : Row(
            //                             children: [
            //                               CircleAvatar(
            //                                 radius: 16,
            //                                 backgroundColor:
            //                                     Colors.blueGrey.shade50,
            //                                 child: Icon(
            //                                   CupertinoIcons.compass_fill,
            //                                   size: 18,
            //                                   color: textColor6,
            //                                 ),
            //                               ),
            //                               const Gap(5),
            //                               Text(
            //                                 propertyFace,
            //                                 overflow: TextOverflow.visible,
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .labelSmall!
            //                                     .copyWith(color: textColor6),
            //                               ),
            //                             ],
            //                           ),
            //             const Gap(10.0),
            //             // Floor Type (only for 'house' subtype)
            //           ],
            //         ),
            //       )
            //     : Center(
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             // Construction Size
            //             Visibility(
            //               visible: constructionSize != "null" &&
            //                   constructionSize != null &&
            //                   constructionSize != "" &&
            //                   constructionSize != "0",
            //               child: Row(
            //                 children: [
            //                   CircleAvatar(
            //                     radius: 16,
            //                     child: SvgPicture.asset(
            //                       "assets/svg/rSize.svg",
            //                       height: 18,
            //                       width: 18,
            //                       color: textColor6,
            //                     ),
            //                   ),
            //                   const Gap(5),
            //                   Text(
            //                     constructionSize ?? "",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelSmall!
            //                         .copyWith(color: textColor6),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             const Gap(10.0),
            //             if (propertyInterior != null || propertyInterior != "")
            //               Row(
            //                 children: [
            //                   CircleAvatar(
            //                     radius: 16,
            //                     backgroundColor: Colors.blueGrey.shade50,
            //                     child: Icon(
            //                       CupertinoIcons.compass_fill,
            //                       size: 18,
            //                       color: textColor6,
            //                     ),
            //                   ),
            //                   const Gap(5),
            //                   Text(
            //                     propertyInterior.toString(),
            //                     overflow: TextOverflow.visible,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelSmall!
            //                         .copyWith(color: textColor6),
            //                   ),
            //                 ],
            //               ),
            //             floorType == null ||
            //                     floorType == "" ||
            //                     floorType == "null" ||
            //                     floorType == "0"
            //                 ? const Offstage()
            //                 : Row(
            //                     children: [
            //                       CircleAvatar(
            //                         radius: 16,
            //                         backgroundColor: Colors.blueGrey.shade50,
            //                         child: Icon(
            //                           CupertinoIcons.compass_fill,
            //                           size: 18,
            //                           color: textColor6,
            //                         ),
            //                       ),
            //                       const Gap(5),
            //                       Text(
            //                         floorType.toString(),
            //                         overflow: TextOverflow.visible,
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .labelSmall!
            //                             .copyWith(color: textColor6),
            //                       ),
            //                     ],
            //                   ),
            //             flatType == null ||
            //                     flatType == "" ||
            //                     flatType == "null" ||
            //                     flatType == "0"
            //                 ? const Offstage()
            //                 : Row(
            //                     children: [
            //                       CircleAvatar(
            //                         radius: 16,
            //                         backgroundColor: Colors.blueGrey.shade50,
            //                         child: Icon(
            //                           CupertinoIcons.compass_fill,
            //                           size: 18,
            //                           color: textColor6,
            //                         ),
            //                       ),
            //                       const Gap(5),
            //                       Text(
            //                         flatType.toString(),
            //                         overflow: TextOverflow.visible,
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .labelSmall!
            //                             .copyWith(color: textColor6),
            //                       ),
            //                     ],
            //                   ),
            //           ],
            //         ),
            //       ),,
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

class FeaturedPropertyCard extends StatelessWidget {
  final CarouselController? carouselController;
  final String forSale;
  final String type;
  final String price;
  final String? priceType;
  final String title;
  final String address;
  final List<Getapiimages> imageList;
  final String? featureImage;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const FeaturedPropertyCard({
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
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withOpacity(0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                // image: DecorationImage(
                //     image:
                //         const AssetImage("assets/images/onBoardImage1.jpg"),
                //     fit: BoxFit.fill,
                //     onError: (exception, stackTrace) {}),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: imageList.isEmpty
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: AppUrl.baseUrl + featureImage.toString(),
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: size.height * 0.15,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.black
                                  // image: DecorationImage(
                                  //     image:
                                  //         const AssetImage("assets/images/onBoardImage1.jpg"),
                                  //     fit: BoxFit.fill,
                                  //     onError: (exception, stackTrace) {}),
                                  ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/png/rprNewLogo.png");
                        },
                      )
                    : CarouselSlider(
                        items: imageList
                            .map(
                              (item) => Image.network(
                                AppUrl.baseUrl + item.filePath.toString(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      "assets/png/rprNewLogo.png");
                                },
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          // aspectRatio: 16 / 9,
                          height: size.height * 0.4,
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          viewportFraction: 1,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
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
                              fontSize: 12.0,
                              color: (forSale == 'Sell' ||
                                      forSale == 'For Sell')
                                  ? Colors.green.shade800
                                  : (forSale == 'Rent' || forSale == 'For Rent')
                                      ? textColor4.withOpacity(0.8)
                                      : accentColor.withOpacity(0.8),
                            ),
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
                            fontSize: 12.0, color: Colors.blue.shade800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                // width: 130,
                child: Text(
                    // "Ravathpura Property Group",
                    maxLines: 2,
                    title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/svg/loc.svg",
                    height: 18,
                    width: 18,
                    color: subTitleColor,
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      // "Near Currency Tower VIP Road Amlidih",
                      address,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: subTitleColor,
                          fontSize: 12.0),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(children: [
                RichText(
                    text: TextSpan(
                        text: price == ""
                            ? ""
                            : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol).format(int.parse(price))} ",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600, color: textColor2),
                        children: [
                      TextSpan(
                          text: "\n  ${priceType}",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  color: subTitleColor)),
                    ]))
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedPropertyCardForMyProperty extends StatelessWidget {
  final CarouselController? carouselController;
  final String forSale;
  final String type;
  final String subType;
  final String price;
  final String? priceType;
  final String title;
  final String views;
  final String address;
  final String? constructionSize;
  final String? openSide;
  final String? propertyFace;
  final List<Getapiimages> imageList;
  final String? featureImage;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapFavorite;
  final bool? isFavorite;
  final bool? isLoading;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const FeaturedPropertyCardForMyProperty({
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
    required this.isFavorite,
    required this.views,
    this.constructionSize,
    this.openSide,
    this.propertyFace,
    this.isLoading,
    this.onTapDelete,
    required this.subType,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
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
                      height: size.height * 0.27,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
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
                                    AppUrl.baseUrl + featureImage.toString() ??
                                        "",
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: size.height * 0.27,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              width: 1, color: Colors.black),
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
                                              height: size.height * 0.25,
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
                                  height: size.height * 0.4,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  viewportFraction: 1,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (views == "0" || views == "" || views.contains("null"))
                            ? const Offstage()
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.orange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        size: 18,
                                        Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      const Gap(5.0),
                                      Text(
                                        views ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        InkWell(
                          onTap: onTapDelete,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 8.0),
                              child: Icon(
                                size: 18,
                                Icons.delete,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            (forSale == null || forSale == "null" || forSale == "")
                ? const Offstage()
                : Padding(
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
                        (type == null || type == "null" || type == "")
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
                        const Gap(10.0),
                        (subType == null || subType == "null" || subType == "")
                            ? const Offstage()
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: textColor6),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  child: Text(
                                    subType,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: buttonTextColor,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                        const Spacer(),
                        price == ""
                            ? Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RichText(
                                    text: TextSpan(
                                  text: price == ""
                                      ? ""
                                      : "${NumberFormat.currency(
                                          locale: 'HI',
                                          symbol: AppText.rupeeSymbol,
                                        ).format(int.parse(price))} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: secondaryColor),
                                )),
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/svg/loc.svg",
                    height: 18,
                    width: 18,
                    color: subTitleColor,
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      // "Near Currency Tower VIP Road Amlidih",
                      address,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: subTitleColor,
                          fontSize: 12.0),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 10.0,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       (constructionSize?.contains("0") == true ||
            //               constructionSize?.contains("null") == true)
            //           ? const SizedBox()
            //           : Row(
            //               children: [
            //                 CircleAvatar(
            //                   radius: 16,
            //                   child: SvgPicture.asset(
            //                     "assets/svg/rSize.svg",
            //                     height: 18,
            //                     width: 18,
            //                     color: textColor6,
            //                   ),
            //                 ),
            //                 const Gap(5),
            //                 Text(
            //                   constructionSize ?? "",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .labelSmall!
            //                       .copyWith(color: textColor6),
            //                 ),
            //               ],
            //             ),
            //       (propertyFace?.contains("0") == true ||
            //               propertyFace?.contains("null") == true)
            //           ? const Offstage()
            //           : Row(
            //               children: [
            //                 CircleAvatar(
            //                   radius: 16,
            //                   backgroundColor: Colors.blueGrey.shade50,
            //                   child: Icon(
            //                     CupertinoIcons.compass_fill,
            //                     size: 18,
            //                     color: textColor6,
            //                   ),
            //                 ),
            //                 const Gap(5),
            //                 SizedBox(
            //                   child: Text(
            //                     propertyFace ?? "",
            //                     overflow: TextOverflow.visible,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelSmall!
            //                         .copyWith(color: textColor6),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //       (openSide?.contains("0") == true ||
            //               openSide?.contains("null") == true)
            //           ? const Offstage()
            //           : Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 CircleAvatar(
            //                   radius: 16,
            //                   backgroundColor: Colors.blueGrey.shade50,
            //                   child: Icon(
            //                     Icons.maps_home_work_outlined,
            //                     size: 18,
            //                     color: textColor6,
            //                   ),
            //                 ),
            //                 const Gap(5),
            //                 Text(
            //                   openSide ?? "",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .labelSmall!
            //                       .copyWith(
            //                         color: textColor6,
            //                       ),
            //                 ),
            //               ],
            //             ),
            //     ],
            //   ),
            // ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
