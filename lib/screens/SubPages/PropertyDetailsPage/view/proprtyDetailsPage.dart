import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/subpages/PropertyDetailsPage/viewModal/propertyDetailsViewModal.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/DotIndicator.dart';
import 'package:fmraipuromes/utils/FeaturePropertyRecommended.dart';
import 'package:fmraipuromes/utils/HomeTitlesHeading.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../../Skeletons/PropertyDetailsSkeleton.dart';
import '../../../../constant/appText.dart';
import '../../../../constant/color.dart';
import '../../../../helper/amounFormatter.dart';

class PropertyDetailsView extends StatefulWidget {
  final String? propertyID;

  const PropertyDetailsView({super.key, this.propertyID});

  @override
  State<PropertyDetailsView> createState() => _PropertyDetailsViewState();
}

class _PropertyDetailsViewState extends State<PropertyDetailsView> {
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  List imageList = [
    {"id": 1, "image_path": "assets/images/onBoardImage1.jpg"},
    {"id": 2, "image_path": "assets/images/onBoardImage2.jpg"},
    {"id": 3, "image_path": "assets/images/onBoardImage3.jpg"},
    {"id": 4, "image_path": "assets/images/onBoardImage4.jpg"},
  ];

  List<Map<dynamic, dynamic>> facilities = [
    {"id": 1, "title": "Wifi", "image_path": "assets/svg/wifi.svg"},
    {"id": 2, "title": "Furniture", "image_path": "assets/svg/bed.svg"},
    {"id": 3, "title": "Elevator", "image_path": "assets/svg/elevator.svg"},
    {"id": 4, "title": "Students", "image_path": "assets/svg/students.svg"},
    {"id": 5, "title": "Vegetarian", "image_path": "assets/svg/veg.svg"},
    {"id": 6, "title": "Male", "image_path": "assets/svg/male.svg"},
    {"id": 7, "title": "Singer", "image_path": "assets/svg/music.svg"},
    {"id": 8, "title": "Football", "image_path": "assets/svg/football.svg"},
  ];

  List availability = [
    {
      "id": 1,
      "title": "Bedroom",
      "Qty": '5',
      "image_path": "assets/svg/bedroom.svg"
    },
    {
      "id": 2,
      "title": "Bathroom",
      "Qty": '2',
      "image_path": "assets/svg/bathtub.svg"
    },
    {
      "id": 3,
      "title": "Square fit",
      "Qty": '2660',
      "image_path": "assets/svg/areaSquare.svg"
    },
  ];

  _firstLoad() async {
    final propertyDetailsPage =
        Provider.of<PropertyDetailsViewController>(context, listen: false);
    if (mounted) {
      await propertyDetailsPage.getPropertyDetails(
          false, widget.propertyID.toString());
      // setState(() {
      //   _isFirstLoadRunning = true;
      // });
      // Future.delayed(const Duration(seconds: 1), () {
      //   setState(() {
      //     _isFirstLoadRunning = false;
      //   });
      // });
    }
  }

  String parsePropertyFace(String propertyFace) {
    try {
      // Try to decode the JSON string
      final List<dynamic> decodedList = jsonDecode(propertyFace);
      // Join the list into a comma-separated string
      return decodedList.take(2).toList().join(",");
    } catch (e) {
      // If an error occurs, return the original string
      return propertyFace;
    }
  }

  final videoURL =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;
  bool videoCompleted = false;

  @override
  void initState() {
    _firstLoad();
    _controller = VideoPlayerController.network(videoURL)
      ..addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          setState(() {
            videoCompleted = true;
          });
        }
      });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(() {
      if (_controller.value.isPlaying && !isPlaying) {
        setState(() {
          isPlaying = true;
          videoCompleted = false; // Reset video completion status
        });
      } else if (!_controller.value.isPlaying && isPlaying) {
        setState(() {
          isPlaying = false;
        });
      }
    });

    super.initState();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _replayVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
    setState(() {
      isPlaying = true;
      videoCompleted = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final propertyDetailsPage =
        Provider.of<PropertyDetailsViewController>(context);
    // String formattedNumber = Formatter.formatNumber(
    //     propertyDetailsPage.porpertyDetailsDataModel.data?.pricing ?? "0");
    return Scaffold(
      body: propertyDetailsPage.isLoading == true
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: PropertyDetailsSkeleton(size: size))
          : ListView(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                  FadeInDown(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: propertyDetailsPage.porpertyDetailsDataModel
                                        .data?.getapiimages?.length ==
                                    0
                                ? CachedNetworkImage(
                                    height: size.height * 0.4,
                                    imageUrl: propertyDetailsPage
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.featureImage !=
                                            ""
                                        ? "${AppUrl.baseUrl}${propertyDetailsPage.porpertyDetailsDataModel.data?.featureImage}"
                                        : "https://img.freepik.com/free-photo/blue-house-with-blue-roof-sky-background_1340-25953.jpg?t=st=1712130201~exp=1712133801~hmac=7b2505906be1b026f3eec826685e50d6eda60a0a7c79e0a5da88d7e72f977c83&w=900",
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    // placeholder: (context, url) {
                                    //   return Center(
                                    //       child: SizedBox(
                                    //     child: CircularProgressIndicator(
                                    //       color: secondaryColor,
                                    //     ),
                                    //   ));
                                    // },
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Center(
                                          child: SizedBox(
                                        child: CircularProgressIndicator(
                                          color: secondaryColor,
                                        ),
                                      ));
                                    },
                                    errorWidget: (context, error, stackTrace) {
                                      return Image.asset(
                                          "assets/png/rprNewLogo.png");
                                    },
                                  )
                                : InkWell(
                                    child: CarouselSlider(
                                      items: propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiimages
                                              ?.map(
                                                (item) => CachedNetworkImage(
                                                  imageUrl: AppUrl.baseUrl +
                                                      item.filePath.toString(),
                                                  fit: BoxFit.fill,
                                                  width: double.infinity,
                                                  errorWidget: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                        "assets/png/rprNewLogo.png");
                                                  },
                                                  placeholder: (context, url) {
                                                    return Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        height:
                                                            size.height * 0.4,
                                                        width: size.width,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                              .toList() ??
                                          [],
                                      carouselController: _carouselController,
                                      options: CarouselOptions(
                                        // aspectRatio: 16 / 9,
                                        height: size.height * 0.4,
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                        autoPlay: true,
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          propertyDetailsPage
                                              .setCurrentIndex(index);
                                          currentIndex = index;
                                        },
                                      ),
                                    ),
                                  ),
                          ),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 50.0, 15.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const CircleAvatar(
                                      radius: 18,
                                      child: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                          "🏡 Property Title : \n${propertyDetailsPage.porpertyDetailsDataModel.data?.title.toString()}"
                                          "\n📍 Location : ${propertyDetailsPage.porpertyDetailsDataModel.data?.jioLocation.toString()}"
                                          "\n ₹ Price : ${NumberFormat.currency(
                                        locale: 'HI',
                                        symbol: AppText.rupeeSymbol,
                                      ).format(int.parse(propertyDetailsPage.porpertyDetailsDataModel.data?.pricing.toString() ?? ''))}"
                                          "\n📏 Size : ${propertyDetailsPage.porpertyDetailsDataModel.data?.size.toString()} SQFT"
                                          "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                          "\n\nCheck out though this link :"
                                          "\nhttps://play.google.com/store/apps/details?id=com.raipurHomes");
                                    },
                                    child: const CircleAvatar(
                                      radius: 18,
                                      child: Icon(Icons.share),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          propertyDetailsPage.porpertyDetailsDataModel.data
                                      ?.getapiimages?.length ==
                                  0
                              ? const SizedBox()
                              : Positioned(
                                  bottom: 10,
                                  right: 20,
                                  left: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Wrap(
                                      alignment: WrapAlignment
                                          .center, // Center align the wrap content
                                      spacing:
                                          4.0, // Horizontal spacing between children
                                      runSpacing: 5.0,
                                      children: List.generate(
                                        propertyDetailsPage
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.getapiimages
                                                ?.length ??
                                            0,
                                        (index) => DotIndicator(
                                          isActive: index == currentIndex,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          // Positioned(
                          //     bottom: 30,
                          //     right: 10,
                          //     child: (propertyDetailsPage
                          //                     .porpertyDetailsDataModel
                          //                     .data
                          //                     ?.visitCount ==
                          //                 "0" ||
                          //             propertyDetailsPage
                          //                     .porpertyDetailsDataModel
                          //                     .data
                          //                     ?.visitCount ==
                          //                 "")
                          //         ? const SizedBox()
                          //         : Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(8),
                          //                 color: Colors.orange,
                          //               ),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     horizontal: 10.0, vertical: 8.0),
                          //                 child: Row(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     const Icon(
                          //                       size: 18,
                          //                       Icons.visibility,
                          //                       color: Colors.white,
                          //                     ),
                          //                     const Gap(5.0),
                          //                     Text(
                          //                       propertyDetailsPage
                          //                               .porpertyDetailsDataModel
                          //                               .data
                          //                               ?.visitCount
                          //                               .toString() ??
                          //                           "",
                          //                       style: Theme.of(context)
                          //                           .textTheme
                          //                           .labelSmall!
                          //                           .copyWith(
                          //                               fontSize: 12.0,
                          //                               color: Colors.white),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ))
                        ],
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
                            color: (propertyDetailsPage
                                            .porpertyDetailsDataModel
                                            .data
                                            ?.getapiCategories
                                            ?.categoriesName ==
                                        'Sell' ||
                                    propertyDetailsPage
                                            .porpertyDetailsDataModel
                                            .data
                                            ?.getapiCategories
                                            ?.categoriesName ==
                                        'For Sell')
                                ? Colors.green.shade50
                                : (propertyDetailsPage
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.getapiCategories
                                                ?.categoriesName ==
                                            'Rent' ||
                                        propertyDetailsPage
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.getapiCategories
                                                ?.categoriesName ==
                                            'For Rent')
                                    ? textColor4.withOpacity(0.1)
                                    : accentColor.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 8.0),
                            child: Text(
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                      ?.getapiCategories?.categoriesName
                                      .toString() ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: (propertyDetailsPage
                                                      .porpertyDetailsDataModel
                                                      .data
                                                      ?.getapiCategories
                                                      ?.categoriesName ==
                                                  'Sell' ||
                                              propertyDetailsPage
                                                      .porpertyDetailsDataModel
                                                      .data
                                                      ?.getapiCategories
                                                      ?.categoriesName ==
                                                  'For Sell')
                                          ? Colors.green.shade800
                                          : (propertyDetailsPage
                                                          .porpertyDetailsDataModel
                                                          .data
                                                          ?.getapiCategories
                                                          ?.categoriesName ==
                                                      'Rent' ||
                                                  propertyDetailsPage
                                                          .porpertyDetailsDataModel
                                                          .data
                                                          ?.getapiCategories
                                                          ?.categoriesName ==
                                                      'For Rent')
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
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                      ?.getapiPType?.name
                                      .toString() ??
                                  "",
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
                            // text:
                            //     "${AppText.rupeeSymbol} ${formattedNumber ?? ""}",
                            text: propertyDetailsPage.porpertyDetailsDataModel
                                        .data?.pricing ==
                                    ""
                                ? ""
                                : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol, decimalDigits: 0).format(int.parse(propertyDetailsPage.porpertyDetailsDataModel.data?.pricing ?? ''))} ",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: secondaryColor),
                            //     children: [
                            //   TextSpan(
                            //     text: propertyDetailController
                            //             .porpertyDetailsDataModel
                            //             .data
                            //             ?.pricetype ??
                            //         "",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .labelSmall!
                            //         .copyWith(
                            //           fontWeight: FontWeight.w400,
                            //           color: textColor4,
                            //         ),
                            //   ),
                            // ],
                          )),
                        )
                      ],
                    ),
                  ),
                  Consumer<PropertyDetailsViewController>(
                    builder: (context, propertyDetailController, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInLeft(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // propertyDetailController
                                      //     .setExpandedTitle();
                                    },
                                    child: SizedBox(
                                      width: size.width * 0.8,
                                      child: Text(
                                          textAlign: TextAlign.left,
                                          // overflow: propertyDetailController
                                          //         .isExpandedTitle
                                          //     ? TextOverflow.visible
                                          //     : TextOverflow.ellipsis,
                                          propertyDetailController
                                                  .porpertyDetailsDataModel
                                                  .data
                                                  ?.title
                                                  .toString() ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // propertyDetailController
                                      //     .setsExpandedSubtitle();
                                    },
                                    child: SizedBox(
                                      width: size.width * 0.8,
                                      child: Text(
                                        // overflow: propertyDetailController
                                        //         .isExpandedSubtitle
                                        //     ? TextOverflow.visible
                                        //     : TextOverflow.ellipsis,
                                        propertyDetailController
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.titleSlug
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: subTitleColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // RichText(
                              //     text: TextSpan(
                              //   text: propertyDetailController
                              //               .porpertyDetailsDataModel
                              //               .data
                              //               ?.pricing ==
                              //           ""
                              //       ? ""
                              //       : "${NumberFormat.currency(locale: 'HI', symbol: AppText.rupeeSymbol, decimalDigits: 0).format(int.parse(propertyDetailController.porpertyDetailsDataModel.data?.pricing.toString() ?? ''))} ",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .labelLarge!
                              //       .copyWith(color: secondaryColor),
                              //   //     children: [
                              //   //   TextSpan(
                              //   //     text: propertyDetailController
                              //   //             .porpertyDetailsDataModel
                              //   //             .data
                              //   //             ?.pricetype ??
                              //   //         "",
                              //   //     style: Theme.of(context)
                              //   //         .textTheme
                              //   //         .labelSmall!
                              //   //         .copyWith(
                              //   //           fontWeight: FontWeight.w400,
                              //   //           color: textColor4,
                              //   //         ),
                              //   //   ),
                              //   // ],
                              // )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10.0),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: SizedBox(
                  //     height: size.height * 0.12,
                  //     child: ListView.builder(
                  //       padding: EdgeInsets.zero,
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: availability.length,
                  //       itemBuilder: (context, index) {
                  //         return Padding(
                  //           padding:
                  //               const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
                  //           child: FadeInRight(
                  //             child: Container(
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(12.0),
                  //                   color: Colors.white,
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Colors.grey.withOpacity(0.2),
                  //                       blurRadius: 3,
                  //                       offset: const Offset(
                  //                           0, 2), // changes position of shadow
                  //                     ),
                  //                   ]),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.symmetric(
                  //                     horizontal: 15.0, vertical: 10),
                  //                 child: Column(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceEvenly,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SvgPicture.asset(
                  //                       availability[index]["image_path"]
                  //                           .toString(),
                  //                       height: 25,
                  //                       width: 25,
                  //                     ),
                  //                     Text(
                  //                       "${availability[index]["Qty"].toString()} ${availability[index]["title"].toString()}",
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .labelSmall,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.residenttype ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.residenttype ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.residenttype ==
                                          0 ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.residenttype ==
                                          "0"
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Residential Type : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          SizedBox(
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.visible,
                                              propertyDetailsPage
                                                      .porpertyDetailsDataModel
                                                      .data
                                                      ?.residenttype ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.address ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.address ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.address ==
                                          0 ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.address ==
                                          "0"
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Location : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.55,
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.visible,
                                              propertyDetailsPage
                                                      .porpertyDetailsDataModel
                                                      .data
                                                      ?.address ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.getapiPType?.name ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiPType
                                              ?.name ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiPType
                                              ?.name ==
                                          "0" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiPType
                                              ?.name ==
                                          0
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Property Type : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.getapiPType
                                                    ?.name ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              (propertyDetailsPage
                                              .porpertyDetailsDataModel.data?.size ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.size ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.size ==
                                          0)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Area Size : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.size ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              parsePropertyFace(propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.propertyface) ==
                                          "" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.propertyface ==
                                          "null"
                                  ? const Offstage()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Facing : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            parsePropertyFace(propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.propertyface) ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              if (propertyDetailsPage.porpertyDetailsDataModel.data
                                          ?.getapiPropertyType?.name ==
                                      "Plot" &&
                                  (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.openside !=
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.openside !=
                                          "0" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.openside !=
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.openside !=
                                          0))
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Open Side : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: subTitleColor),
                                      ),
                                      Text(
                                        propertyDetailsPage
                                                .porpertyDetailsDataModel
                                                .data
                                                ?.openside ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              if ((propertyDetailsPage.porpertyDetailsDataModel
                                              .data?.getapiPropertyType?.name ==
                                          "house" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiPropertyType
                                              ?.name ==
                                          "Flat") &&
                                  (propertyDetailsPage.porpertyDetailsDataModel
                                              .data?.floortype ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data!
                                              .floortype !=
                                          "0"))
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Floor Type : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: subTitleColor),
                                      ),
                                      Text(
                                        propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.floortype ==
                                                0
                                            ? ""
                                            : propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.floortype
                                                    .toString() ??
                                                "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ),

                              (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.flattype ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.flattype ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.flattype
                                              ?.contains("0") ==
                                          true)
                                  ? const Offstage()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "No. of BHK : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.flattype ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              // (propertyDetailsPage.porpertyDetailsDataModel.data
                              //                 ?.room ==
                              //             "null" ||
                              //         propertyDetailsPage
                              //                 .porpertyDetailsDataModel
                              //                 .data
                              //                 ?.room
                              //                 ?.contains("0") ==
                              //             true)
                              //     ? const Offstage()
                              //     : Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 4.0),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               "Bedroom : ",
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .labelSmall!
                              //                   .copyWith(color: subTitleColor),
                              //             ),
                              //             Text(
                              //               propertyDetailsPage
                              //                       .porpertyDetailsDataModel
                              //                       .data
                              //                       ?.room ??
                              //                   "",
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .labelSmall,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              // (propertyDetailsPage.porpertyDetailsDataModel.data
                              //                 ?.bathroom ==
                              //             "null" ||
                              //         propertyDetailsPage
                              //                 .porpertyDetailsDataModel
                              //                 .data
                              //                 ?.bathroom
                              //                 ?.contains("0") ==
                              //             true)
                              //     ? const Offstage()
                              //     : Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 4.0),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               "Bathroom : ",
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .labelSmall!
                              //                   .copyWith(color: subTitleColor),
                              //             ),
                              //             Text(
                              //               propertyDetailsPage
                              //                       .porpertyDetailsDataModel
                              //                       .data
                              //                       ?.bathroom ??
                              //                   "",
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .labelSmall,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.constructionSize ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.constructionSize ==
                                          null)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Construction Size : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.constructionSize ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.propertyinterior ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.propertyinterior ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.propertyinterior
                                              ?.contains("0") ==
                                          true)
                                  ? const Offstage()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Interior Status : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.propertyinterior ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.constructionstatus ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.constructionstatus
                                              ?.contains("0") ==
                                          true ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.constructionstatus ==
                                          0 ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.constructionstatus ==
                                          null)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Property Status : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.constructionstatus ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),

                              (propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.roadsize ==
                                          "null" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.roadsize ==
                                          null ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.roadsize ==
                                          0)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Road Size : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          Text(
                                            "${propertyDetailsPage.porpertyDetailsDataModel.data?.roadsize} (Ft.)" ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                              propertyDetailsPage.porpertyDetailsDataModel.data
                                              ?.connectivity ==
                                          "" ||
                                      propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.connectivity
                                              .toString() ==
                                          "null"
                                  ? const Offstage()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Connectivity : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.55,
                                            child: Text(
                                              "${propertyDetailsPage.porpertyDetailsDataModel.data?.connectivity ?? ""}",
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.visible,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10.0),
                  FadeInUp(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        //   child: ExpansionTile(
                        //     tilePadding:
                        //         const EdgeInsets.symmetric(horizontal: 5.0),
                        //     collapsedShape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     collapsedBackgroundColor: Colors.white,
                        //     backgroundColor: Colors.white,
                        //     title: Text(
                        //       "Details and Features",
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .labelSmall!
                        //           .copyWith(fontWeight: FontWeight.w600),
                        //     ),
                        //     children: [
                        //       GridView.builder(
                        //         shrinkWrap: true,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         padding: EdgeInsets.zero,
                        //         itemCount: 8,
                        //         itemBuilder: (context, index) {
                        //           return Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: FadeInDown(
                        //               child: Container(
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(8.0),
                        //                   color: Colors.grey.shade50,
                        //                 ),
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceEvenly,
                        //                   children: [
                        //                     const Icon(
                        //                       Icons.bed_outlined,
                        //                       size: 20,
                        //                     ),
                        //                     const Text(":"),
                        //                     Text("3 Kitchen Facilities",
                        //                         style: Theme.of(context)
                        //                             .textTheme
                        //                             .labelSmall!
                        //                             .copyWith(fontSize: 12.0))
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //                 crossAxisCount: 2, mainAxisExtent: 50),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const Gap(10.0),
                        propertyDetailsPage.porpertyDetailsDataModel.data
                                    ?.ameneties?.length ==
                                0
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  collapsedBackgroundColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    "Amenities",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.ameneties
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInDown(
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.grey.shade50,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .check_mark_circled,
                                                    size: 20,
                                                    color:
                                                        Colors.green.shade400,
                                                  ),
                                                  const Text(":"),
                                                  Text(
                                                      propertyDetailsPage
                                                              .porpertyDetailsDataModel
                                                              .data
                                                              ?.ameneties?[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              fontSize: 12.0))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 50),
                                    ),
                                  ],
                                ),
                              ),
                        const Gap(10),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        //   child: ExpansionTile(
                        //     tilePadding:
                        //         const EdgeInsets.symmetric(horizontal: 5.0),
                        //     collapsedShape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     collapsedBackgroundColor: Colors.white,
                        //     backgroundColor: Colors.white,
                        //     title: Text(
                        //       "Property Video",
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .labelSmall!
                        //           .copyWith(fontWeight: FontWeight.w600),
                        //     ),
                        //     children: [
                        //       Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: ZoomIn(
                        //             child: Container(
                        //               height: size.height * 0.3,
                        //               width: size.width,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(
                        //                   12.0,
                        //                 ),
                        //                 color: Colors.grey.shade50,
                        //               ),
                        //               child: _initializeVideoPlayerFuture ==
                        //                       null
                        //                   ? const CircularProgressIndicator()
                        //                   : _initializeVideoPlayerFuture ==
                        //                           false
                        //                       ? const Center(
                        //                           child: Text(
                        //                               'Failed to initialize video player'),
                        //                         )
                        //                       : Center(
                        //                           child: _controller
                        //                                   .value.isInitialized
                        //                               ? Column(
                        //                                   children: [
                        //                                     Container(
                        //                                       decoration:
                        //                                           BoxDecoration(
                        //                                         borderRadius:
                        //                                             BorderRadius
                        //                                                 .circular(
                        //                                                     12.0),
                        //                                       ),
                        //                                       child:
                        //                                           AspectRatio(
                        //                                         aspectRatio:
                        //                                             _controller
                        //                                                 .value
                        //                                                 .aspectRatio,
                        //                                         child:
                        //                                             Container(
                        //                                           decoration:
                        //                                               BoxDecoration(
                        //                                             borderRadius:
                        //                                                 BorderRadius.circular(
                        //                                                     12.0),
                        //                                           ),
                        //                                           child: Stack(
                        //                                             alignment:
                        //                                                 Alignment
                        //                                                     .bottomCenter,
                        //                                             children: [
                        //                                               VideoPlayer(
                        //                                                   _controller),
                        //                                               VideoProgressIndicator(
                        //                                                 _controller,
                        //                                                 allowScrubbing:
                        //                                                     true,
                        //                                                 colors:
                        //                                                     VideoProgressColors(
                        //                                                   playedColor:
                        //                                                       secondaryColor,
                        //                                                   bufferedColor:
                        //                                                       Colors.grey,
                        //                                                   backgroundColor:
                        //                                                       Colors.transparent,
                        //                                                 ),
                        //                                               ),
                        //                                             ],
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                     Row(
                        //                                       mainAxisAlignment:
                        //                                           MainAxisAlignment
                        //                                               .center,
                        //                                       children: [
                        //                                         IconButton(
                        //                                           icon: Icon(
                        //                                             isPlaying
                        //                                                 ? Icons
                        //                                                     .pause
                        //                                                 : Icons
                        //                                                     .play_arrow,
                        //                                           ),
                        //                                           onPressed:
                        //                                               () {
                        //                                             setState(
                        //                                                 () {
                        //                                               _togglePlayPause();
                        //                                             });
                        //                                           },
                        //                                         ),
                        //                                         IconButton(
                        //                                             icon: Icon(
                        //                                               videoCompleted
                        //                                                   ? Icons
                        //                                                       .replay
                        //                                                   : Icons
                        //                                                       .replay_outlined,
                        //                                               color: Colors
                        //                                                   .black,
                        //                                             ),
                        //                                             onPressed:
                        //                                                 _replayVideo),
                        //                                       ],
                        //                                     ),
                        //                                   ],
                        //                                 )
                        //                               : const CircularProgressIndicator(),
                        //                         ),
                        //             ),
                        //           ))
                        //     ],
                        //   ),
                        // ),
                        // const Gap(10),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        //   child: ExpansionTile(
                        //     tilePadding:
                        //         const EdgeInsets.symmetric(horizontal: 5.0),
                        //     collapsedShape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0)),
                        //     collapsedBackgroundColor: Colors.white,
                        //     backgroundColor: Colors.white,
                        //     title: Text(
                        //       "Floor Plan",
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .labelSmall!
                        //           .copyWith(fontWeight: FontWeight.w600),
                        //     ),
                        //     children: [
                        //       FadeInDown(
                        //         child: Column(
                        //           children: [
                        //             ExpansionTile(
                        //               title: Row(
                        //                 children: [
                        //                   Text(
                        //                     "First Floor",
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .labelSmall,
                        //                   ),
                        //                   const Gap(5.0),
                        //                   Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(6.0),
                        //                       color: Colors.grey.shade100,
                        //                     ),
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                               horizontal: 8.0,
                        //                               vertical: 5),
                        //                       child: Text(
                        //                         "740 sq ft",
                        //                         style: Theme.of(context)
                        //                             .textTheme
                        //                             .labelSmall!
                        //                             .copyWith(fontSize: 12.0),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //             ExpansionTile(
                        //               title: Row(
                        //                 children: [
                        //                   Text(
                        //                     "Second Floor",
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .labelSmall,
                        //                   ),
                        //                   const Gap(5.0),
                        //                   Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(6.0),
                        //                       color: Colors.grey.shade100,
                        //                     ),
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                               horizontal: 8.0,
                        //                               vertical: 5),
                        //                       child: Text(
                        //                         "710 sq ft",
                        //                         style: Theme.of(context)
                        //                             .textTheme
                        //                             .labelSmall!
                        //                             .copyWith(fontSize: 12.0),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //             ExpansionTile(
                        //               title: Row(
                        //                 children: [
                        //                   Text(
                        //                     "Garage",
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .labelSmall,
                        //                   ),
                        //                   const Gap(5.0),
                        //                   Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(6.0),
                        //                       color: Colors.grey.shade100,
                        //                     ),
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                               horizontal: 8.0,
                        //                               vertical: 5),
                        //                       child: Text(
                        //                         "520 sq ft",
                        //                         style: Theme.of(context)
                        //                             .textTheme
                        //                             .labelSmall!
                        //                             .copyWith(fontSize: 12.0),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const Gap(10),
                        propertyDetailsPage.porpertyDetailsDataModel.data
                                    ?.getapiimages?.length ==
                                0
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  collapsedBackgroundColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    "More Images",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: propertyDetailsPage
                                              .porpertyDetailsDataModel
                                              .data
                                              ?.getapiimages
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInDown(
                                            child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.grey.shade50,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          "${AppUrl.baseUrl}${propertyDetailsPage.porpertyDetailsDataModel.data?.getapiimages?[index].filePath ?? ""}")),
                                                )),
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 150),
                                    ),
                                  ],
                                ),
                              ),
                        const Gap(10),
                      ],
                    ),
                  ),

                  // FadeIn(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //         child: Text(
                  //           "Property Descriptions",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .labelSmall!
                  //               .copyWith(fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //       Consumer<PropertyDetailsViewController>(
                  //         builder: (context, propertyDetailController, child) {
                  //           return Padding(
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 15.0),
                  //             child: InkWell(
                  //               onTap: () {
                  //                 propertyDetailController.setsExpanded();
                  //               },
                  //               child: LayoutBuilder(
                  //                 builder: (context, constraints) {
                  //                   String fullText =
                  //                       "Experience serene living on this expansive land property nestled amidst nature's beauty. "
                  //                       "Spanning acres of lush greenery, this picturesque landscape offers endless possibilities for development or personal retreat.";
                  //                   String shortText =
                  //                       fullText.substring(0, 100);
                  //                   return RichText(
                  //                     text: TextSpan(
                  //                         text: propertyDetailController
                  //                                 .isExpanded
                  //                             ? fullText
                  //                             : "$shortText.....",
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .labelSmall!
                  //                             .copyWith(color: subTitleColor),
                  //                         children: [
                  //                           TextSpan(
                  //                               recognizer: TapGestureRecognizer()
                  //                                 ..onTap = () =>
                  //                                     propertyDetailController
                  //                                         .setsExpanded(),
                  //                               text: propertyDetailController
                  //                                       .isExpanded
                  //                                   ? "read less"
                  //                                   : "read more",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .labelSmall!
                  //                                   .copyWith(
                  //                                       fontWeight:
                  //                                           FontWeight.w600))
                  //                         ]),
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // FadeInLeft(
                  //   child: SubPageTitlesHeading(
                  //     title: "Facilities",
                  //     subtitle: "View all",
                  //     onTap: () {
                  //       showModalBottomSheet(
                  //         backgroundColor: Colors.transparent,
                  //         context: context,
                  //         builder: (context) {
                  //           return Container(
                  //             height: size.height * 0.35,
                  //             width: size.width,
                  //             decoration: const BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(20),
                  //                   topRight: Radius.circular(20),
                  //                 )),
                  //             child: Column(
                  //               children: [
                  //                 const Gap(10),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Gap(40),
                  //                     const Spacer(),
                  //                     Text("Facilities",
                  //                         textAlign: TextAlign.center,
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .labelSmall!
                  //                             .copyWith(
                  //                                 fontWeight: FontWeight.w600)),
                  //                     const Spacer(),
                  //                     IconButton(
                  //                         onPressed: () =>
                  //                             Navigator.pop(context),
                  //                         icon: const Icon(
                  //                           Icons.close,
                  //                           color: Colors.black,
                  //                         ))
                  //                   ],
                  //                 ),
                  //                 const Divider(),
                  //                 Expanded(
                  //                   child: GridView.builder(
                  //                     shrinkWrap: true,
                  //                     physics:
                  //                         const NeverScrollableScrollPhysics(),
                  //                     padding: EdgeInsets.zero,
                  //                     itemCount: facilities.length,
                  //                     itemBuilder: (context, index) {
                  //                       return Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: FadeInUp(
                  //                           child: Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.center,
                  //                             children: [
                  //                               CircleAvatar(
                  //                                   radius: 30,
                  //                                   backgroundColor:
                  //                                       Colors.grey.shade100,
                  //                                   child: SvgPicture.asset(
                  //                                     facilities[index]
                  //                                         ["image_path"],
                  //                                     height: 24,
                  //                                     width: 24,
                  //                                     color: Colors.black,
                  //                                   )),
                  //                               Text(
                  //                                 facilities[index]["title"],
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .labelSmall!
                  //                                     .copyWith(fontSize: 12.0),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                     gridDelegate:
                  //                         const SliverGridDelegateWithFixedCrossAxisCount(
                  //                             crossAxisCount: 4,
                  //                             mainAxisExtent: 100),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: facilities.take(4).map((map) {
                  //         return FadeInRight(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               CircleAvatar(
                  //                   radius: 30,
                  //                   backgroundColor: Colors.white,
                  //                   child: SvgPicture.asset(
                  //                     map["image_path"],
                  //                     height: 24,
                  //                     width: 24,
                  //                     color: Colors.black,
                  //                   )),
                  //               Text(
                  //                 map["title"],
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .labelSmall!
                  //                     .copyWith(fontSize: 12.0),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }).toList(),
                  //     )),

                  const Gap(10.0),
                  propertyDetailsPage.porpertyDetailsDataModel
                              .suggestionProperty?.length ==
                          0
                      ? const SizedBox()
                      : FadeInLeft(
                          child: const SubPageTitlesHeading(
                            title: "Featured Properties",
                          ),
                        ),
                  propertyDetailsPage.porpertyDetailsDataModel
                              .suggestionProperty?.length ==
                          0
                      ? const SizedBox()
                      : SizedBox(
                          height: size.height * 0.23,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: propertyDetailsPage
                                    .porpertyDetailsDataModel
                                    .suggestionProperty
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return FadeInRight(
                                child: FeaturePropertyRecommended(
                                  size: size,
                                  onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.propertyDetailView,
                                      arguments: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .serviceId
                                          .toString()),
                                  title: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .title
                                          .toString() ??
                                      "",
                                  address: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .address
                                          .toString() ??
                                      "",
                                  propertyType: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .getapiCategories
                                          ?.categoriesName
                                          .toString() ??
                                      "",
                                  type: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .getpropertySubType
                                          ?.name
                                          .toString() ??
                                      "",
                                  image:
                                      "${AppUrl.baseUrl}${propertyDetailsPage.porpertyDetailsDataModel.suggestionProperty?[index].featureImage.toString() ?? ""}",
                                  price: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .pricing
                                          .toString() ??
                                      "",
                                  priceType: propertyDetailsPage
                                          .porpertyDetailsDataModel
                                          .suggestionProperty?[index]
                                          .pricetype
                                          .toString() ??
                                      "",
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                  const Gap(20),
                ]),
      bottomNavigationBar: propertyDetailsPage.isLoading == true
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: accentColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 12, 30, 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.call_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const Gap(5),
                                  Text(
                                    "Call",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: buttonTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: const Color(0xFF008000),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 12, 30, 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.chat_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const Gap(5),
                                  Text(
                                    "SMS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: buttonTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: accentColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ]),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          : SizedBox(
              height: kBottomNavigationBarHeight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FadeInUp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async => await ContactFeatures()
                            .launchCalling(
                                context,
                                propertyDetailsPage.porpertyDetailsDataModel
                                        .adminDetails?.adminNumber
                                        .toString() ??
                                    ""),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: secondaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: secondaryColor.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.call_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const Gap(5),
                                Text(
                                  "Call",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: buttonTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async => await ContactFeatures()
                            .launchWhatsapp(
                                context,
                                propertyDetailsPage.porpertyDetailsDataModel
                                        .adminDetails?.adminWhatsappNumber
                                        .toString() ??
                                    "",
                                "Hii i am interested in this property"
                                "\n\n🏡 Property Title : \n${propertyDetailsPage.porpertyDetailsDataModel.data?.title.toString()}"
                                "\n📍 Location : ${propertyDetailsPage.porpertyDetailsDataModel.data?.jioLocation.toString()}"
                                "\n ₹ Price : ${NumberFormat.currency(
                                  locale: 'HI',
                                  symbol: AppText.rupeeSymbol,
                                ).format(int.parse(propertyDetailsPage.porpertyDetailsDataModel.data?.pricing.toString() ?? ''))}"
                                "\n📏 Size : ${propertyDetailsPage.porpertyDetailsDataModel.data?.size.toString()} SQFT"
                                "\n\nProperty Link Here:"
                                "\nhttps://www.raipurhomes.com/property-details/${propertyDetailsPage.porpertyDetailsDataModel.data?.titleSlug.toString()}-${propertyDetailsPage.porpertyDetailsDataModel.data?.serviceId.toString()}"),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: const Color(0xFF008000),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/whatsapp.svg",
                                  color: Colors.white,
                                  height: 24,
                                  width: 24,
                                ),
                                const Gap(5),
                                Text(
                                  "Whatsapp",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: buttonTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          propertyDetailsPage
                              .setIsFav(widget.propertyID.toString());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: const Color(0xFFb93b54),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                propertyDetailsPage.porpertyDetailsDataModel
                                            .data?.loading ==
                                        true
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ))
                                    : Icon(
                                        propertyDetailsPage
                                                    .porpertyDetailsDataModel
                                                    .data
                                                    ?.getBookMarkedProperty !=
                                                null
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
