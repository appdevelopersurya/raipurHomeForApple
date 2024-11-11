import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fmraipuromes/Skeletons/GridSkeleton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/FeaturedPropertyCard.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/appText.dart';
import '../../../../constant/color.dart';

class PopularLocationPropertyList extends StatefulWidget {
  final PassFilterModel passFilterModel;

  const PopularLocationPropertyList({super.key, required this.passFilterModel});

  @override
  State<PopularLocationPropertyList> createState() =>
      _PopularLocationPropertyListState();
}

class _PopularLocationPropertyListState
    extends State<PopularLocationPropertyList> {
  _firstLoad() async {
    final popularLocationPropertyListViewModal =
        Provider.of<PopularLocationPropertyListViewModal>(context,
            listen: false);
    if (mounted) {
      var body = {"current_area": widget.passFilterModel.id.toString()};
      print("single location body=====> $body");
      popularLocationPropertyListViewModal.getActualFilterProperty(body);
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  Future _onRefresh() {
    return Future.delayed(const Duration(seconds: 2), () {
      return _firstLoad();
    });
  }

  String parsePropertyFace(String propertyFace) {
    try {
      final List<dynamic> decodedList = jsonDecode(propertyFace);
      return decodedList.take(2).toList().join(",");
    } catch (e) {
      return propertyFace;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final popularLocationPropertyListViewModal =
        Provider.of<PopularLocationPropertyListViewModal>(context);

    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: Container(
                // decoration: const BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Color(0xFFffffff),
                //       Color(0xFFf3ef66),
                //     ],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //   ),
                // ),
                ),
            // backgroundColor: textColor5,
            elevation: 1,
            centerTitle: true,
            title: Text(
              widget.passFilterModel.title.toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: textColor2),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: borderColor)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: textColor2,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: borderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.filterNew);
                        },
                        child: SvgPicture.asset(
                          "assets/svg/filterOn.svg",
                          color: textColor2,
                          height: 27,
                          width: 27,
                        )),
                  ),
                ),
              ),
            ],
          ),
          body: popularLocationPropertyListViewModal.isLoading == true
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade50,
                  child: const GridSkeleton())
              : Column(
                  children: [
                    Expanded(
                      child: FadeInDown(
                          child: popularLocationPropertyListViewModal
                                      .allPropertyModel.data?.length ==
                                  0
                              ? Center(
                                  child: Lottie.asset("assets/gif/noData.json"))
                              : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  // Setting grid layout
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: 0.625,
                                  ),
                                  itemCount:
                                      popularLocationPropertyListViewModal
                                          .allPropertyModel.data?.length,
                                  itemBuilder: (context, index) {
                                    if (kDebugMode) {
                                      print(
                                          "${AppUrl.baseUrl}${popularLocationPropertyListViewModal.allPropertyModel.data?[index].featureImage.toString()}");
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FeaturedPropertyGridCardForHome(
                                        onTapShare: () {
                                          Share.share(
                                              "🏡 Property Title : \n${popularLocationPropertyListViewModal.allPropertyModel.data?[index].title.toString()}"
                                              "\n📍 Location : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].jioLocation.toString()}"
                                              "\n ₹ Price : ${NumberFormat.currency(
                                            locale: 'HI',
                                            symbol: AppText.rupeeSymbol,
                                          ).format(int.parse(popularLocationPropertyListViewModal.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                              "\n📏 Size : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].size.toString()} SQFT"
                                              "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                              "\n\nCheck out through this link :"
                                              "\nhttps://www.raipurhomes.com/property-details/${popularLocationPropertyListViewModal.allPropertyModel.data?[index].titleSlug.toString()}-${popularLocationPropertyListViewModal.allPropertyModel.data?[index].serviceId.toString()}");
                                        },
                                        onTapCall: () async =>
                                            await ContactFeatures().launchCalling(
                                                context,
                                                popularLocationPropertyListViewModal
                                                        .allPropertyModel
                                                        .adminDetails
                                                        ?.adminNumber
                                                        .toString() ??
                                                    ""),
                                        onTapWhatsapp: () async => await ContactFeatures()
                                            .launchWhatsapp(
                                                context,
                                                popularLocationPropertyListViewModal
                                                        .allPropertyModel
                                                        .adminDetails
                                                        ?.adminWhatsappNumber
                                                        .toString() ??
                                                    "",
                                                "Hii i am interested in this property"
                                                "\n\n🏡 Property Title : \n${popularLocationPropertyListViewModal.allPropertyModel.data?[index].title.toString()}"
                                                "\n📍 Location : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].jioLocation.toString()}"
                                                "\n ₹ Price : ${NumberFormat.currency(
                                                  locale: 'HI',
                                                  symbol: AppText.rupeeSymbol,
                                                ).format(int.parse(popularLocationPropertyListViewModal.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                                "\n📏 Size : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].size.toString()} SQFT"
                                                "\n\nProperty Link Here:"
                                                "\nhttps://www.raipurhomes.com/property-details/${popularLocationPropertyListViewModal.allPropertyModel.data?[index].titleSlug.toString()}-${popularLocationPropertyListViewModal.allPropertyModel.data?[index].serviceId.toString()}"),
                                        onTap: () => Navigator.pushNamed(
                                            context,
                                            AppRoutes.propertyDetailView,
                                            arguments:
                                                popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .serviceId
                                                    .toString()),
                                        views:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .visitCount
                                                    .toString() ??
                                                "",
                                        size: size,
                                        forSale:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .getapiCategories
                                                    ?.categoriesName
                                                    .toString() ??
                                                "",
                                        type:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .getapiPropertySubType
                                                    ?.name
                                                    .toString() ??
                                                "",
                                        price:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .pricing
                                                    .toString() ??
                                                "",
                                        title:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .title
                                                    .toString() ??
                                                "",
                                        address:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .address
                                                    .toString() ??
                                                "",
                                        imageList:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .getapiimages ??
                                                [],
                                        featureImage:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .featureImage ??
                                                "",
                                        priceType:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .pricetype
                                                    .toString() ??
                                                "",
                                        constructionSize:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .size
                                                    .toString() ??
                                                "",
                                        propertyFace: parsePropertyFace(
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .propertyface
                                                    .toString() ??
                                                ""),
                                        openSide:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .openside
                                                    .toString() ??
                                                "",
                                        onTapFavorite: () {
                                          if (box.read(
                                                  "access_token_raipurHomes") ==
                                              "") {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Container(
                                                    constraints: BoxConstraints
                                                        .loose(const Size
                                                            .fromHeight(400)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: FadeInDown(
                                                            child: Stack(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundColor:
                                                                      secondaryColor,
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        const AssetImage(
                                                                      "assets/icons/contact.png",
                                                                    ),
                                                                    backgroundColor:
                                                                        primaryColor,
                                                                    radius: 48,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  right: 0,
                                                                  child:
                                                                      CircleAvatar(
                                                                          radius:
                                                                              18,
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                errorColor,
                                                                            size:
                                                                                18,
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        FadeInRight(
                                                          child: Text(
                                                            "You're currently using a guest account. Please log in.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                        ),
                                                        FadeInLeft(
                                                          child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            'Log in to enjoy all the features and a customized experience.',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color:
                                                                        subTitleColor),
                                                          ),
                                                        ),
                                                        const Gap(20),
                                                        FadeInDown(
                                                          child: CustomButton(
                                                              onTap: () =>
                                                                  Navigator
                                                                      .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    AppRoutes
                                                                        .loginNumber,
                                                                    (route) =>
                                                                        false,
                                                                  ),
                                                              title:
                                                                  "Yes, Login"),
                                                        ),
                                                        const Gap(10),
                                                        FadeInUp(
                                                          child: TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              'Not Now',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .copyWith(
                                                                      color:
                                                                          errorColor),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            popularLocationPropertyListViewModal
                                                .setIsFav(
                                                    popularLocationPropertyListViewModal
                                                            .allPropertyModel
                                                            .data?[index]
                                                            .serviceId
                                                            .toString() ??
                                                        "",
                                                    index);
                                          }
                                        },
                                        isLoading:
                                            popularLocationPropertyListViewModal
                                                .allPropertyModel
                                                .data?[index]
                                                .loading,
                                        isFavorite:
                                            popularLocationPropertyListViewModal
                                                        .allPropertyModel
                                                        .data?[index]
                                                        .getBookMarkedProperty !=
                                                    null
                                                ? true
                                                : false,
                                        subType:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .getapiPropertyType
                                                    ?.name
                                                    .toString() ??
                                                "",
                                        floorType:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .floortype
                                                    .toString() ??
                                                "",
                                        flatType:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .flattype
                                                    .toString() ??
                                                "",
                                        propertyInterior:
                                            popularLocationPropertyListViewModal
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .propertyinterior
                                                    .toString() ??
                                                "",
                                      ),
                                    );
                                  },
                                )),
                    ),
                  ],
                ),
        ));
  }
}

class LocationPropertyCard extends StatelessWidget {
  final Size size;
  final String image;
  final String title;
  final String subTitle;
  final String address;
  final String faceSide;
  final String category;
  final String propertyType;
  final String flattype;
  final String? views;
  final String pricing;
  final String room;
  final String constructionSize;
  final String openSide;
  final String propertyFace;
  final VoidCallback? onTap;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapFavorite;
  final bool isFavorite;

  const LocationPropertyCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.address,
      required this.category,
      required this.propertyType,
      this.onTap,
      required this.image,
      required this.size,
      required this.flattype,
      required this.room,
      required this.constructionSize,
      required this.pricing,
      this.views,
      required this.isFavorite,
      this.onTapCall,
      this.onTapWhatsapp,
      this.onTapFavorite,
      required this.faceSide,
      required this.openSide,
      required this.propertyFace});

  @override
  Widget build(BuildContext context) {
    print("image url ==> $image");
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: CachedNetworkImage(
                          height: 250,
                          width: size.width,
                          fit: BoxFit.cover,
                          imageUrl: image,
                          placeholder: (context, url) {
                            return const SizedBox(
                              height: 100,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5.0),
                      //           color: Colors.teal,
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 3.0, horizontal: 5.0),
                      //           child: Row(
                      //             children: [
                      //               const Icon(
                      //                 Icons.circle,
                      //                 size: 10,
                      //                 color: Colors.white,
                      //               ),
                      //               const Gap(3),
                      //               Text(
                      //                 "Verified",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .labelSmall!
                      //                     .copyWith(
                      //                         color: Colors.white, fontSize: 10.0),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //       const Gap(5),
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5.0),
                      //           color: textColor4,
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 3.0, horizontal: 5.0),
                      //           child: Row(
                      //             children: [
                      //               const Icon(
                      //                 Icons.nights_stay,
                      //                 size: 10,
                      //                 color: Colors.white,
                      //               ),
                      //               const Gap(3),
                      //               Text(
                      //                 "New",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .labelSmall!
                      //                     .copyWith(
                      //                         color: Colors.white, fontSize: 10.0),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //       const Spacer(),
                      //       CircleAvatar(
                      //         backgroundColor: Colors.grey.shade200,
                      //         radius: 10,
                      //         child: const Icon(
                      //           Icons.favorite_border,
                      //           size: 18,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      (views == "0" || views == "" || views == null)
                          ? const Offstage()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.orange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
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
                                            .copyWith(
                                                fontSize: 12.0,
                                                color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: (category == 'Sell' || category == 'For Sell')
                          ? Colors.green.shade50
                          : (category == 'Rent' || category == 'For Rent')
                              ? textColor4.withOpacity(0.1)
                              : accentColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: (category == 'Sell' ||
                                    category == 'For Sell')
                                ? Colors.green.shade800
                                : (category == 'Rent' || category == 'For Rent')
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
                        propertyType,
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
                      text: pricing == ""
                          ? ""
                          : "${NumberFormat.currency(
                              locale: 'HI',
                              symbol: AppText.rupeeSymbol,
                            ).format(int.parse(pricing))} ",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: secondaryColor),
                    )),
                  )
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (constructionSize.contains("0") == true ||
                          constructionSize.contains("null") == true)
                      ? const SizedBox()
                      : Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              child: SvgPicture.asset(
                                "assets/svg/rSize.svg",
                                height: 18,
                                width: 18,
                                color: textColor6,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              constructionSize,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: textColor6),
                            ),
                          ],
                        ),
                  (propertyFace.contains("") == false ||
                          propertyFace.contains("null") == false)
                      ? Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blueGrey.shade50,
                              child: Icon(
                                CupertinoIcons.compass_fill,
                                size: 18,
                                color: textColor6,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              propertyFace,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: textColor6),
                            ),
                          ],
                        )
                      : const Offstage(),
                  (openSide.contains("0") == true ||
                          openSide.contains("null") == true)
                      ? const Offstage()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blueGrey.shade50,
                              child: Icon(
                                Icons.maps_home_work_outlined,
                                size: 18,
                                color: textColor6,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              openSide ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: textColor6,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                InkWell(
                  onTap: onTapFavorite,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: textColor4.withOpacity(0.1),
                      child: Icon(
                        isFavorite
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
