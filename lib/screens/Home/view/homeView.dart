import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/Skeletons/HomeSkeleton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/appText.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/PopularAllListArgModal.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/helper/amounFormatter.dart';
import 'package:fmraipuromes/repository/bookMarkController.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/screens/Drawer/view/mainDrawerNew.dart';
import 'package:fmraipuromes/screens/Home/viewModal/homeViewController.dart';
import 'package:fmraipuromes/screens/SubPages/OurProjects/viewModel/OurProjectsViewsModel.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportViewModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/FeaturedPropertyCard.dart';
import 'package:fmraipuromes/utils/HomeAppBar.dart';
import 'package:fmraipuromes/utils/HomeTitlesHeading.dart';
import 'package:fmraipuromes/utils/KeyboardUtils.dart';
import 'package:fmraipuromes/utils/popularlocation.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:fmraipuromes/utils/youtubePlayer.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/HandPickedPropertyCard.dart';
import '../../SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  Timer? _timer;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  dynamic voiceText;

  make() async {
    final popularLocationPropertyListViewModal =
        Provider.of<PopularLocationPropertyListViewModal>(context,
            listen: false);
    popularLocationPropertyListViewModal
        .setIsAvailable(await _speechToText.initialize());
  }

  List<String> apartmentList = [
    "Shankar Nagar",
    "Naya Raipur",
    "Avanti Vihar",
    "Amlidih",
    "Bhanthagao"
  ];

  String featuredPType = "Buy";

  _firstLoad() async {
    _searchController.clear();
    final homeViewController =
        Provider.of<HomeVIewController>(context, listen: false);
    final supportViewController =
        Provider.of<SupportViewModel>(context, listen: false);
    final ourProjectsList =
        Provider.of<OurProjectsViewModel>(context, listen: false);
    if (mounted) {
      homeViewController.checkPermission();
      homeViewController.getBanner(false);
      homeViewController.getTrendingArea(false);
      homeViewController.getFeatureProperty(false, featuredPType);
      homeViewController.getSuggestionData(false);
      supportViewController.getContactDetails();
      ourProjectsList.getProjectList();
      getGreeting();
      Provider.of<GetFilterTools>(context, listen: false);
    }
  }

  final List<Map<String, dynamic>> list1 = List.generate(10, (index) {
    return {
      'id': index,
      'value': Random().nextInt(100),
    };
  });

  final List<Map<String, dynamic>> list2 = List.generate(10, (index) {
    return {
      'id': index,
      'value': Random().nextInt(100),
    };
  });

  @override
  void initState() {
    _firstLoad();
    make();
    _startAutoScroll();
    _startAutoScroll2();

    super.initState();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.offset;
        final newScrollPosition = currentScrollPosition + 200;

        if (newScrollPosition <= maxScrollExtent) {
          _scrollController.animateTo(
            newScrollPosition,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _startAutoScroll2() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController2.hasClients) {
        final maxScrollExtent = _scrollController2.position.maxScrollExtent;
        final currentScrollPosition = _scrollController2.offset;
        final newScrollPosition = currentScrollPosition + 200;

        if (newScrollPosition <= maxScrollExtent) {
          _scrollController2.animateTo(
            newScrollPosition,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController2.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
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

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future _onRefresh() {
    return _firstLoad();
  }

  void _showVoiceSpeedDialog(PopularLocationPropertyListViewModal value1) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Save the dialog context
        final dialogContext = context;
        // Start a timer to close the dialog after 4 seconds
        Timer(const Duration(seconds: 4), () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });
        return AlertDialog(
          title: Text(
            'Start Speech',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: AvatarGlow(
                  animate: true,
                  glowColor: textColor3,
                  child: CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.mic,
                      size: 30,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              const Gap(20.0),
            ],
          ),
        );
      },
    ).then((v) {
      value1.setVoiceEnable(false);
      _speechToText.stop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewController = Provider.of<HomeVIewController>(context);
    final supportViewController = Provider.of<SupportViewModel>(context);
    final ourProjectViewController = Provider.of<OurProjectsViewModel>(context);
    Provider.of<BookMarkController>(context);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Confirm',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            content: Text(
              'Are you sure you want to exit ?',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ], //
          ),
        );
        return confirm;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
            key: _scaffoldKey,
            // drawer: const MainDrawerNew(),
            endDrawer: const MainDrawerNew(),
            appBar: HomeAppBar(
              scaffoldKey: _scaffoldKey,
              onTapLogo: () => _onRefresh(),
            ),
            body: Consumer<HomeVIewController>(
              builder: (context, value, child) {
                return value.isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade50,
                        child: const HomeSkeleton())
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          FadeInDown(
                            child: SizedBox(
                              height: size.width >= 640
                                  ? size.height * 0.7
                                  : size.height * 0.4,
                              // color: Colors.red,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    child: FadeInDown(
                                      child: SizedBox(
                                        height: size.width >= 640
                                            ? size.height * 0.45
                                            : size.height * 0.23,
                                        width: size.width,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: size.width >= 640
                                                ? size.height * 0.8
                                                : size.height * 0.32,
                                            // aspectRatio: size.width >= 640
                                            //     ? 16 / 9
                                            //     : 16 / 5,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 600),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            viewportFraction: 1.05,
                                          ),
                                          items: homeViewController
                                              .bannerDataModel.data
                                              ?.map((item) {
                                            return InkWell(
                                              onTap: () {
                                                if (item.url != null) {
                                                  ContactFeatures()
                                                      .gotoRaipurBuilder(
                                                          context,
                                                          item.url.toString(),
                                                          "Raipur Builder");
                                                }
                                              },
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: AppUrl.baseUrl +
                                                    item.sliderImg.toString(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/png/rprNewLogo.png"),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 50,
                                  //   left: 15,
                                  //   child: CachedNetworkImage(
                                  //     height: 70,
                                  //     width: 70,
                                  //     fit: BoxFit.cover,
                                  //     imageUrl:
                                  //         "https://i.postimg.cc/qv7SgJsy/cropped-Untitled-design-1-1.png",
                                  //     errorWidget: (context, url, error) =>
                                  //         Image.asset("assets/png/rprNewLogo.png"),
                                  //   ),
                                  // ),
                                  searchSectionsHome(size, homeViewController),
                                  // Positioned(
                                  //   top: 50,
                                  //   right: 15,
                                  //   child: InkWell(
                                  //     onTap: () => _scaffoldKey.currentState!
                                  //         .openEndDrawer(),
                                  //     child: CircleAvatar(
                                  //       backgroundColor: secondaryColor,
                                  //       child: SvgPicture.asset(
                                  //         "assets/svg/menu.svg",
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Positioned(
                                  //   top: 50,
                                  //   right: 60,
                                  //   child: InkWell(
                                  //     onTap: () => Navigator.pushNamed(
                                  //         context, AppRoutes.support),
                                  //     child: CircleAvatar(
                                  //       backgroundColor: secondaryColor,
                                  //       child: Image.asset(
                                  //         "assets/icons/support.png",
                                  //         color: Colors.white,
                                  //         height: 22,
                                  //         width: 22,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          // FadeInDown(
                          //   child: Container(
                          //     height: size.height * 0.16,
                          //     width: size.width,
                          //     decoration: BoxDecoration(
                          //       // color: secondaryColor,
                          //       borderRadius: BorderRadius.circular(16.0),
                          //     ),
                          //     child: CarouselSlider(
                          //       options: CarouselOptions(
                          //         aspectRatio: 16 / 7,
                          //         onPageChanged: (index, reason) {
                          //           setState(() {});
                          //         },
                          //         // height: 130.0,
                          //         autoPlay: true,
                          //         autoPlayInterval: const Duration(seconds: 3),
                          //         autoPlayAnimationDuration:
                          //             const Duration(milliseconds: 800),
                          //         autoPlayCurve: Curves.fastOutSlowIn,
                          //         viewportFraction: 1.0,
                          //       ),
                          //       items: homeViewController.bannerDataModel.data
                          //           ?.map((item) {
                          //         return Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(16.0),
                          //           ),
                          //           child: ClipRRect(
                          //             borderRadius: BorderRadius.circular(16.0),
                          //             child: CachedNetworkImage(
                          //               fit: BoxFit.cover,
                          //               imageUrl: AppUrl.baseUrl +
                          //                   item.sliderImg.toString(),
                          //               errorWidget: (context, url, error) =>
                          //                   Image.asset(
                          //                       "assets/png/rprNewLogo.png"),
                          //             ),
                          //           ),
                          //         );
                          //       }).toList(),
                          //     ),
                          //   ),
                          // ),

                          FadeInLeft(
                            child: HomeTitlesHeading(
                              title: "Trending Area In Raipur",
                              subtitle: "View all",
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.popularLocations,
                                  arguments: PopularAllListArgsModal(
                                      pageTitle: "Trending Area In Raipur",
                                      pageType: "location",
                                      category: ""),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                              height: size.width >= 640
                                  ? size.height * 0.45
                                  : size.height * 0.22,
                              width: size.width * 0.9,
                              child: ListView.builder(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    value.trendingAreaModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return FadeInRight(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes
                                                .popularLocationPropertyList,
                                            arguments: PassFilterModel(
                                                id: homeViewController
                                                        .trendingAreaModel
                                                        .data?[index]
                                                        .id ??
                                                    0,
                                                title: homeViewController
                                                        .trendingAreaModel
                                                        .data?[index]
                                                        .name
                                                        .toString() ??
                                                    "",
                                                logLate: "singleLocation"));
                                        context
                                            .read<GetFilterTools>()
                                            .setTownId(homeViewController
                                                    .trendingAreaModel
                                                    .data?[index]
                                                    .id
                                                    .toString() ??
                                                "");
                                      },
                                      child: PopularLocation(
                                        image: homeViewController
                                                .trendingAreaModel
                                                .data?[index]
                                                .image
                                                .toString() ??
                                            "",
                                        locationName: homeViewController
                                                .trendingAreaModel
                                                .data?[index]
                                                .name
                                                .toString() ??
                                            "",
                                        // propertyQty: "2",
                                      ),
                                    ),
                                  );
                                },
                              )),
                          FadeInLeft(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 50.0),
                              child: InkWell(
                                onTap: () {
                                  if (box.read("access_token_raipurHomes") ==
                                      "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints.loose(
                                                const Size.fromHeight(400)),
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FadeInDown(
                                                    child: Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              secondaryColor,
                                                          child: CircleAvatar(
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
                                                          child: CircleAvatar(
                                                              radius: 18,
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    errorColor,
                                                                size: 18,
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
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
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
                                                    textAlign: TextAlign.center,
                                                    'Log in to enjoy all the features and a customized experience.',
                                                    style: Theme.of(context)
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
                                                      onTap: () => Navigator
                                                              .pushNamedAndRemoveUntil(
                                                            context,
                                                            AppRoutes
                                                                .loginNumber,
                                                            (route) => false,
                                                          ),
                                                      title: "Yes, Login"),
                                                ),
                                                const Gap(10),
                                                FadeInUp(
                                                  child: TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Not Now',
                                                      style: Theme.of(context)
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
                                    Navigator.pushNamed(
                                            context, AppRoutes.postProperty)
                                        .whenComplete(
                                      () {
                                        final imageController =
                                            context.read<GetImageFromUser>();
                                        imageController.removeImage();
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: textColor2,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child: Text("Post Property",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: buttonTextColor)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10.0),
                          FadeInRight(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          featuredPType = "Buy";
                                        });
                                        homeViewController.getFeatureProperty(
                                            false, featuredPType);
                                      },
                                      child: Container(
                                        width: size.width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: featuredPType == "Buy"
                                              ? secondaryColor
                                              : Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          child: Text(
                                            "Buy",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                  color: featuredPType == "Buy"
                                                      ? buttonTextColor
                                                      : textColor3,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(10.0),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          featuredPType = "Rent";
                                        });
                                        homeViewController.getFeatureProperty(
                                            false, featuredPType);
                                      },
                                      child: Container(
                                        width: size.width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: featuredPType == "Rent"
                                              ? secondaryColor
                                              : Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          child: Text(
                                            "Rent",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color:
                                                        featuredPType == "Rent"
                                                            ? buttonTextColor
                                                            : textColor3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(10.0),
                          FadeInLeft(
                            child: HomeTitlesHeading(
                              title: "Featured Property For $featuredPType",
                              subtitle: "View all",
                              onTap: () {
                                Navigator.pushNamed(
                                        context, AppRoutes.popularLocations,
                                        arguments: PopularAllListArgsModal(
                                            pageTitle: "All Properties",
                                            pageType: "allProperties",
                                            category: ""))
                                    .whenComplete(
                                  () => _firstLoad(),
                                );
                              },
                            ),
                          ),
                          Consumer<HomeVIewController>(
                            builder: (context, value, child) {
                              return FadeInRight(
                                duration: const Duration(milliseconds: 800),
                                child: SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: min(
                                        value.allPropertyModel.data?.length ??
                                            0,
                                        10),
                                    itemBuilder: (context, index) {
                                      return FeaturedPropertyCardForHome(
                                        onTapShare: () {
                                          Share.share(
                                              "🏡 Property Title : \n${value.allPropertyModel.data?[index].title.toString()}"
                                              "\n📍 Location : ${value.allPropertyModel.data?[index].jioLocation.toString()}"
                                              "\n ₹ Price : ${NumberFormat.currency(
                                            locale: 'HI',
                                            symbol: AppText.rupeeSymbol,
                                          ).format(int.parse(value.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                              "\n📏 Size : ${value.allPropertyModel.data?[index].size.toString()} SQFT"
                                              "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                              "\n\nCheck out through this link :"
                                              "\nhttps://www.raipurhomes.com/property-details/${value.allPropertyModel.data?[index].titleSlug.toString()}-${value.allPropertyModel.data?[index].serviceId.toString()}");
                                        },
                                        onTapCall: () async =>
                                            await ContactFeatures()
                                                .launchCalling(
                                                    context,
                                                    value
                                                            .allPropertyModel
                                                            .adminDetails
                                                            ?.adminNumber
                                                            .toString() ??
                                                        ""),
                                        onTapWhatsapp: () async => await ContactFeatures()
                                            .launchWhatsapp(
                                                context,
                                                value
                                                        .allPropertyModel
                                                        .adminDetails
                                                        ?.adminWhatsappNumber
                                                        .toString() ??
                                                    "",
                                                "Hii i am interested in this property"
                                                "\n\n🏡 Property Title : \n${value.allPropertyModel.data?[index].title.toString()}"
                                                "\n📍 Location : ${value.allPropertyModel.data?[index].jioLocation.toString()}"
                                                "\n ₹ Price : ${NumberFormat.currency(
                                                  locale: 'HI',
                                                  symbol: AppText.rupeeSymbol,
                                                ).format(int.parse(value.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                                "\n📏 Size : ${value.allPropertyModel.data?[index].size.toString()} SQFT"
                                                "\n\nProperty Link Here:"
                                                "\nhttps://www.raipurhomes.com/property-details/${value.allPropertyModel.data?[index].titleSlug.toString()}-${value.allPropertyModel.data?[index].serviceId.toString()}"),
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
                                            value.setIsFav(
                                                value.allPropertyModel
                                                        .data?[index].serviceId
                                                        .toString() ??
                                                    "",
                                                index);
                                          }
                                        },
                                        isLoading: value.allPropertyModel
                                            .data?[index].loading,
                                        isFavorite: value
                                                    .allPropertyModel
                                                    .data?[index]
                                                    .getBookMarkedProperty !=
                                                null
                                            ? true
                                            : false,
                                        onTap: () => Navigator.pushNamed(
                                            context,
                                            AppRoutes.propertyDetailView,
                                            arguments: value.allPropertyModel
                                                .data?[index].serviceId
                                                .toString()),
                                        views: value.allPropertyModel
                                                .data?[index].visitCount
                                                .toString() ??
                                            "",
                                        size: size,
                                        forSale: value
                                                .allPropertyModel
                                                .data?[index]
                                                .getapiCategories
                                                ?.categoriesName
                                                .toString() ??
                                            "",
                                        type: value
                                                .allPropertyModel
                                                .data?[index]
                                                .getapiPropertySubType
                                                ?.name
                                                .toString() ??
                                            "",
                                        price: value.allPropertyModel
                                                .data?[index].pricing
                                                .toString() ??
                                            "",
                                        title: value.allPropertyModel
                                                .data?[index].title
                                                .toString() ??
                                            "",
                                        address: value.allPropertyModel
                                                .data?[index].address
                                                .toString() ??
                                            "",
                                        imageList: value.allPropertyModel
                                                .data?[index].getapiimages ??
                                            [],
                                        featureImage: value.allPropertyModel
                                                .data?[index].featureImage ??
                                            "",
                                        priceType: value.allPropertyModel
                                                .data?[index].pricetype
                                                .toString() ??
                                            "",
                                        constructionSize: value.allPropertyModel
                                                .data?[index].size
                                                .toString() ??
                                            "",
                                        propertyFace: parsePropertyFace(value
                                                .allPropertyModel
                                                .data?[index]
                                                .propertyface
                                                .toString() ??
                                            ""),
                                        openSide: value.allPropertyModel
                                                .data?[index].openside
                                                .toString() ??
                                            "",
                                        subType: value
                                                .allPropertyModel
                                                .data?[index]
                                                .getapiPropertyType
                                                ?.name
                                                .toString() ??
                                            "",
                                        floorType: value.allPropertyModel
                                                .data?[index].floortype
                                                .toString() ??
                                            "",
                                        flatType: value.allPropertyModel
                                                .data?[index].flattype
                                                .toString() ??
                                            "",
                                        propertyInterior: value.allPropertyModel
                                                .data?[index].propertyinterior
                                                .toString() ??
                                            "",
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          homeViewController.allPropertyModel.data?.length != 0
                              ? FadeInLeft(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator
                                                .pushNamed(context,
                                                    AppRoutes.popularLocations,
                                                    arguments:
                                                        PopularAllListArgsModal(
                                                            pageTitle:
                                                                "All Properties",
                                                            pageType:
                                                                "allProperties",
                                                            category: ""))
                                            .whenComplete(() => _firstLoad());
                                      },
                                      child: Text(
                                        "View All Property",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: textColor2),
                                      )),
                                )
                              : const Offstage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: FadeInDown(
                              child: Container(
                                width: size.width * 0.015,
                                height: size.width >= 640
                                    ? size.height * 0.7
                                    : size.height * 0.27,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/postPropertyImage.jpg")),
                                  border: Border.all(
                                      width: 1, color: secondaryColor),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: RichText(
                                                overflow: TextOverflow.visible,
                                                text: TextSpan(
                                                    text:
                                                        "Get a free assessment \nof your property's worth\nexplore now!",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                            color:
                                                                secondaryColor2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    children: [
                                                      TextSpan(
                                                        text: "\nFree",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                                color:
                                                                    secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ]),
                                              ),
                                            )),
                                        const FadeInImage(
                                            height: 100,
                                            width: 100,
                                            image: AssetImage(
                                              "assets/png/propertyAdd2.png",
                                            ),
                                            placeholder: AssetImage(
                                              "assets/png/propertyAdd2.png",
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
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
                                            Navigator.pushNamed(context,
                                                    AppRoutes.postProperty)
                                                .whenComplete(
                                              () {
                                                final imageController = context
                                                    .read<GetImageFromUser>();
                                                imageController.removeImage();
                                              },
                                            );
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: textColor2,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 10),
                                            child: Text("Post Property",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        color:
                                                            buttonTextColor)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          featuredPType == "Rent"
                              ? FadeInLeft(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator
                                                .pushNamed(context,
                                                    AppRoutes.popularLocations,
                                                    arguments:
                                                        PopularAllListArgsModal(
                                                            pageTitle:
                                                                "All Properties",
                                                            pageType:
                                                                "allProperties",
                                                            category: ""))
                                            .whenComplete(() => _firstLoad());
                                      },
                                      child: Text(
                                        'Rent Solution by "Raipur Homes"',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: textColor2),
                                      )),
                                )
                              : const Offstage(),
                          featuredPType == "Rent"
                              ? Text(
                                  textAlign: TextAlign.center,
                                  "GET STARTED WITH EXPLORING RENT OPTIONS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: textColor3),
                                )
                              : const Offstage(),
                          const Gap(10.0),
                          featuredPType == "Rent"
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: homeViewController
                                          .trendingAreaModel.data?.length ??
                                      0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              )
                                            ],
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/rentbackpik.jpg"),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors
                                                            .red.shade800)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                      homeViewController
                                                              .trendingAreaModel
                                                              .data?[index]
                                                              .name ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                            color: textColor2,
                                                          )),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Gap(5),
                                                    const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      "House For Rent : ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    ),
                                                    Text(
                                                        list1[index]['value']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall),
                                                    const Gap(5),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Gap(5),
                                                    const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      "Flat For Rent : ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    ),
                                                    Text(
                                                        list2[index]['value']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall),
                                                    const Gap(5),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (box.read(
                                                              "access_token_raipurHomes") ==
                                                          "") {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              child: Container(
                                                                constraints: BoxConstraints
                                                                    .loose(const Size
                                                                        .fromHeight(
                                                                        400)),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          FadeInDown(
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            CircleAvatar(
                                                                              radius: 50,
                                                                              backgroundColor: secondaryColor,
                                                                              child: CircleAvatar(
                                                                                backgroundImage: const AssetImage(
                                                                                  "assets/icons/contact.png",
                                                                                ),
                                                                                backgroundColor: primaryColor,
                                                                                radius: 48,
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              bottom: 0,
                                                                              right: 0,
                                                                              child: CircleAvatar(
                                                                                  radius: 18,
                                                                                  child: Icon(
                                                                                    Icons.close,
                                                                                    color: errorColor,
                                                                                    size: 18,
                                                                                  )),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    FadeInRight(
                                                                      child:
                                                                          Text(
                                                                        "You're currently using a guest account. Please log in.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .labelMedium!
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                    FadeInLeft(
                                                                      child:
                                                                          Text(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        'Log in to enjoy all the features and a customized experience.',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .labelSmall!
                                                                            .copyWith(color: subTitleColor),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        20),
                                                                    FadeInDown(
                                                                      child: CustomButton(
                                                                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                                                                                context,
                                                                                AppRoutes.loginNumber,
                                                                                (route) => false,
                                                                              ),
                                                                          title: "Yes, Login"),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    FadeInUp(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        child:
                                                                            Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          'Not Now',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .labelSmall!
                                                                              .copyWith(color: errorColor),
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
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes.support);
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.red.shade800,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text("Query",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: SizedBox(
                                                      height: 20,
                                                      child: VerticalDivider(
                                                        color: Colors.black,
                                                        thickness: 2,
                                                        width: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      ContactFeatures().launchCalling(
                                                          context,
                                                          supportViewController
                                                                  .contactUsDataModel
                                                                  .data
                                                                  ?.adminNumber
                                                                  .toString()
                                                                  .trim() ??
                                                              "");
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text("Call",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: SizedBox(
                                                      height: 20,
                                                      child: VerticalDivider(
                                                        color: Colors.black,
                                                        thickness: 2,
                                                        width: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      ContactFeatures().launchWhatsapp(
                                                          context,
                                                          supportViewController
                                                                  .contactUsDataModel
                                                                  .data
                                                                  ?.adminWhatsappNumber
                                                                  .toString()
                                                                  .trim() ??
                                                              "",
                                                          "Hi, I am interested in the property at this location. Can you share more information about the property in this area?");
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text("Chat",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Offstage(),
                          FadeInLeft(
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Tie-Up Projects In Raipur",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: textColor2),
                                )),
                          ),
                          SizedBox(
                              height: size.width >= 640
                                  ? size.height * 0.5
                                  : size.height * 0.235,
                              width: size.width * 0.9,
                              child: ListView.builder(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    value.trendingAreaModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return FadeInRight(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.ourProjects,
                                            arguments: PassFilterModel(
                                                id: ourProjectViewController
                                                        .ourProjectDataModels
                                                        .data?[index]
                                                        .id
                                                        ?.toInt() ??
                                                    0,
                                                title: ourProjectViewController
                                                        .ourProjectDataModels
                                                        .data?[index]
                                                        .projectName
                                                        .toString() ??
                                                    "",
                                                logLate: "singleLocation"));
                                      },
                                      child: PopularLocationSquare(
                                        image: ourProjectViewController
                                                .ourProjectDataModels
                                                .data?[index]
                                                .projectImage
                                                .toString() ??
                                            "",
                                        locationName: ourProjectViewController
                                                .ourProjectDataModels
                                                .data?[index]
                                                .projectName
                                                .toString() ??
                                            "",
                                        // propertyQty: "2",
                                      ),
                                    ),
                                  );
                                },
                              )),
                          homeViewController.bannerDataModel.exploreCategory
                                      ?.length !=
                                  0
                              ? FadeInLeft(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator
                                                .pushNamed(context,
                                                    AppRoutes.popularLocations,
                                                    arguments:
                                                        PopularAllListArgsModal(
                                                            pageTitle:
                                                                "All Properties",
                                                            pageType:
                                                                "allProperties",
                                                            category: ""))
                                            .whenComplete(() => _firstLoad());
                                      },
                                      child: Text(
                                        "Explore Categories",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: textColor2),
                                      )),
                                )
                              : const Offstage(),
                          Text(
                            textAlign: TextAlign.center,
                            "Find Best Categories in town with Raipur Homes",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: textColor3),
                          ),
                          const Gap(10.0),
                          homeViewController.bannerDataModel.exploreCategory
                                      ?.length !=
                                  0
                              ? SizedBox(
                                  height: size.height * 0.295,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeViewController
                                            .bannerDataModel
                                            .exploreCategory
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return FadeInRight(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.mainFilter,
                                                arguments: PassFilterModel(
                                                    id: homeViewController
                                                            .bannerDataModel
                                                            .exploreCategory?[
                                                                index]
                                                            .id ??
                                                        0,
                                                    logLate: "cat",
                                                    title: "Main Filter"),
                                              );
                                            },
                                            child: Container(
                                              width: size.height * 0.27,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 3),
                                                    )
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Container(
                                                    //   height: size.height * 0.18,
                                                    //   width: size.height * 0.27,
                                                    //   decoration: BoxDecoration(
                                                    //       borderRadius:
                                                    //           BorderRadius.circular(
                                                    //               16.0),
                                                    //       image: const DecorationImage(
                                                    //           fit: BoxFit.fill,
                                                    //           image: AssetImage(
                                                    //               "assets/images/exclusiveBanner.jpg"))),
                                                    // ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      child: CachedNetworkImage(
                                                        height:
                                                            size.height * 0.18,
                                                        width:
                                                            size.height * 0.27,
                                                        fit: BoxFit.fill,
                                                        imageUrl: homeViewController
                                                                .bannerDataModel
                                                                .exploreCategory?[
                                                                    index]
                                                                .image
                                                                .toString() ??
                                                            "",
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                Transform.scale(
                                                          scale: 0.5,
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    const Gap(10.0),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                homeViewController
                                                                        .bannerDataModel
                                                                        .exploreCategory?[
                                                                            index]
                                                                        .name
                                                                        .toString() ??
                                                                    "",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .copyWith(
                                                                        color:
                                                                            textColor2)),
                                                            Text(
                                                                "${homeViewController.bannerDataModel.exploreCategory?[index].propertiesCount.toString() ?? ""} Properties",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                        color:
                                                                            textColor3))
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                color: secondaryColor2
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(3.0),
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  size: 18,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Offstage(),
                          const Gap(10.0),
                          homeViewController.bannerDataModel.exploreCategory
                                      ?.length !=
                                  0
                              ? FadeInUp(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2))
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FadeInRight(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: YoutubeVideoPlayerCard(
                                                borderRadius: 12.0,
                                                url: supportViewController
                                                    .contactUsDataModel
                                                    .data
                                                    ?.videoLink,
                                                autoPlayVideo: false,
                                                showControls: true,
                                              ),
                                            ),
                                          ),
                                          const Gap(10.0),
                                          InkWell(
                                            onTap: () {
                                              Utils.downloadFile(
                                                url: AppUrl.baseUrl +
                                                    supportViewController
                                                        .contactUsDataModel
                                                        .data
                                                        ?.pdfLink,
                                                onProgress: (progress) {
                                                  homeViewController
                                                      .setDownloadProgress(
                                                          progress);
                                                },
                                                onDownloadCompleted: (path) {
                                                  homeViewController
                                                      .setDownloadProgress(
                                                          null);
                                                },
                                                context: context,
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svg/diamond_shape.svg",
                                                  color: Colors.teal
                                                      .withOpacity(0.3),
                                                  height: 80,
                                                  width: 80,
                                                ),
                                                Positioned(
                                                  right: 3,
                                                  left: 3,
                                                  bottom: 3,
                                                  top: 3,
                                                  child: homeViewController
                                                              .downloadProgress !=
                                                          null
                                                      ? Transform.scale(
                                                          scale: 0.50,
                                                          // Adjust the scale factor to set the desired size
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors
                                                                .grey.shade800,
                                                            strokeWidth: 5,
                                                          ),
                                                        )
                                                      : Transform.scale(
                                                          scale: 2,
                                                          child: Lottie.asset(
                                                            "assets/gif/download.json",
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(10.0),
                                          Text(
                                            "Download and Browse",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          const Gap(10.0),
                                          Text(
                                            "Raipur Homes",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(color: accentColor),
                                          ),
                                          const Gap(10.0),
                                          Text(
                                            "Ek Prayash to Fulfill Your Dreams",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: errorColor),
                                          ),
                                          const Gap(10.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const Offstage(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInUp(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "To Read Read Top Most Articles On Home Buying",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: textColor2),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInRight(
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.blogView),
                                child: Container(
                                  height: 200,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/onBoardImage4.jpg"))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.8)),
                                          width: size.width * 0.55,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        "Discover your dream home among our selection of new properties and houses for sale. ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                    children: [
                                                      TextSpan(
                                                        text: "Read more",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                      )
                                                    ]),
                                              )),
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: textColor2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInUp(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryColor2.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Raipur Homes?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: textColor2,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "Extensive Property Listings",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "Streamlined Search Process",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "Exclusive Deals and Offers",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "Expert Guidance",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "Real-Time Updates",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: textColor2,
                                                  ),
                                                  const Gap(5.0),
                                                  Text(
                                                    "User-Friendly Interface",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: textColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20.0),
                          FadeInUp(
                            child: GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 280,
                                      mainAxisSpacing: 10.0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minHeight: 200), // Set minimum height
                                    child: Container(
                                      // width: size.width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: textColor2,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                "assets/icons/broker.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Avoid Broker",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: buttonTextColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: buttonTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minHeight: 200), // Set minimum height
                                    child: Container(
                                      // width: size.width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: textColor2,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/icons/bookMarks.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Select your Favourite",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: buttonTextColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: buttonTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minHeight: 200), // Set minimum height
                                    child: Container(
                                      // width: size.width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: textColor2,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/icons/document.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Free Documentation Process",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: buttonTextColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: buttonTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minHeight: 200), // Set minimum height
                                    child: Container(
                                      // width: size.width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: textColor2,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/icons/personalUser.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Support Registry Process",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: buttonTextColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "We are supporting our clients booking process to registry process.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: buttonTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // FadeInRight(
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         child: ConstrainedBox(
                          //           constraints: const BoxConstraints(
                          //               minHeight: 200), // Set minimum height
                          //           child: Container(
                          //             width: size.width * 0.7,
                          //             decoration: BoxDecoration(
                          //               color: textColor2,
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.grey.withOpacity(0.2),
                          //                   blurRadius: 3,
                          //                   offset: const Offset(0, 2),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Image.asset(
                          //                       "assets/icons/broker.png",
                          //                       height: 100,
                          //                       width: 100,
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Text(
                          //                   textAlign: TextAlign.center,
                          //                   "Avoid Broker",
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .labelLarge!
                          //                       .copyWith(
                          //                           color: buttonTextColor),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     textAlign: TextAlign.center,
                          //                     "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .labelSmall!
                          //                         .copyWith(
                          //                             color: buttonTextColor),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         child: ConstrainedBox(
                          //           constraints: const BoxConstraints(
                          //               minHeight: 200), // Set minimum height
                          //           child: Container(
                          //             width: size.width * 0.7,
                          //             decoration: BoxDecoration(
                          //               color: textColor2,
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.grey.withOpacity(0.2),
                          //                   blurRadius: 3,
                          //                   offset: const Offset(0, 2),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Image.asset(
                          //                       "assets/icons/bookMarks.png",
                          //                       height: 100,
                          //                       width: 100,
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Text(
                          //                   textAlign: TextAlign.center,
                          //                   "Select your Favourite",
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .labelLarge!
                          //                       .copyWith(
                          //                           color: buttonTextColor),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     textAlign: TextAlign.center,
                          //                     "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .labelSmall!
                          //                         .copyWith(
                          //                             color: buttonTextColor),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         child: ConstrainedBox(
                          //           constraints: const BoxConstraints(
                          //               minHeight: 200), // Set minimum height
                          //           child: Container(
                          //             width: size.width * 0.7,
                          //             decoration: BoxDecoration(
                          //               color: textColor2,
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.grey.withOpacity(0.2),
                          //                   blurRadius: 3,
                          //                   offset: const Offset(0, 2),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Image.asset(
                          //                       "assets/icons/document.png",
                          //                       height: 100,
                          //                       width: 100,
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Text(
                          //                   textAlign: TextAlign.center,
                          //                   "Free Documentation Process",
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .labelLarge!
                          //                       .copyWith(
                          //                           color: buttonTextColor),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     textAlign: TextAlign.center,
                          //                     "No broker involvement by any kind of agent with us we will provide every possible lisiting with best deal.",
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .labelSmall!
                          //                         .copyWith(
                          //                             color: buttonTextColor),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         child: ConstrainedBox(
                          //           constraints: const BoxConstraints(
                          //               minHeight: 200), // Set minimum height
                          //           child: Container(
                          //             width: size.width * 0.7,
                          //             decoration: BoxDecoration(
                          //               color: textColor2,
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color:
                          //                       Colors.grey.withOpacity(0.2),
                          //                   blurRadius: 3,
                          //                   offset: const Offset(0, 2),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Image.asset(
                          //                       "assets/icons/personalUser.png",
                          //                       height: 100,
                          //                       width: 100,
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Text(
                          //                   textAlign: TextAlign.center,
                          //                   "Support Registry Process",
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .labelLarge!
                          //                       .copyWith(
                          //                           color: buttonTextColor),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     textAlign: TextAlign.center,
                          //                     "We are supporting our clients booking process to registry process.",
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .labelSmall!
                          //                         .copyWith(
                          //                             color: buttonTextColor),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Gap(20.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: FadeInUp(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: textColor2,
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(20.0),
                                    FadeInDown(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: Image.asset(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            "assets/png/rprNewLogo.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "We’re not just in the business of buying and selling properties; we’re in the business of making dreams come true. We believe that a home is not just a place; it’s an emotion, a sanctuary, and the foundation of countless memories waiting to be created.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: buttonTextColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              supportViewController
                                                          .contactUsDataModel
                                                          .data
                                                          ?.adminNumber ==
                                                      null
                                                  ? const Offstage()
                                                  : InkWell(
                                                      onTap: () {
                                                        ContactFeatures().launchCalling(
                                                            context,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.adminNumber
                                                                    .toString()
                                                                    .trim() ??
                                                                "");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.call,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          const Gap(5.0),
                                                          Text(
                                                            textAlign:
                                                                TextAlign.left,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.adminNumber
                                                                    .toString()
                                                                    .trim() ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelMedium!
                                                                .copyWith(
                                                                    color:
                                                                        buttonTextColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              supportViewController
                                                          .contactUsDataModel
                                                          .data
                                                          ?.number2 ==
                                                      null
                                                  ? const Offstage()
                                                  : InkWell(
                                                      onTap: () {
                                                        ContactFeatures().launchCalling(
                                                            context,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.number2
                                                                    .toString()
                                                                    .trim() ??
                                                                "");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.call,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          const Gap(5.0),
                                                          Text(
                                                            textAlign:
                                                                TextAlign.left,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.number2
                                                                    .toString()
                                                                    .trim() ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelMedium!
                                                                .copyWith(
                                                                    color:
                                                                        buttonTextColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              supportViewController
                                                          .contactUsDataModel
                                                          .data
                                                          ?.number3 ==
                                                      null
                                                  ? const Offstage()
                                                  : InkWell(
                                                      onTap: () {
                                                        ContactFeatures().launchCalling(
                                                            context,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.number3
                                                                    .toString()
                                                                    .trim() ??
                                                                "");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.call,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          const Gap(5.0),
                                                          Text(
                                                            textAlign:
                                                                TextAlign.left,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.number3
                                                                    .toString()
                                                                    .trim() ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelMedium!
                                                                .copyWith(
                                                                    color:
                                                                        buttonTextColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              supportViewController
                                                          .contactUsDataModel
                                                          .data
                                                          ?.adminEmail ==
                                                      null
                                                  ? const Offstage()
                                                  : InkWell(
                                                      onTap: () {
                                                        ContactFeatures().launchEmail(
                                                            context,
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.adminEmail
                                                                    .toString()
                                                                    .trim() ??
                                                                "");
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.email,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          const Gap(5.0),
                                                          Text(
                                                            supportViewController
                                                                    .contactUsDataModel
                                                                    .data
                                                                    ?.adminEmail
                                                                    .toString()
                                                                    .trim() ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelMedium!
                                                                .copyWith(
                                                                    color:
                                                                        buttonTextColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              const Gap(10.0),
                                              Text(
                                                textAlign: TextAlign.left,
                                                "Contact Us",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: buttonTextColor),
                                              ),
                                              const Gap(10.0),
                                              SizedBox(
                                                width: size.width >= 640
                                                    ? size.width * 0.94
                                                    : size.width * 0.9,
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  supportViewController
                                                          .contactUsDataModel
                                                          .data
                                                          ?.address
                                                          .toString() ??
                                                      "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          color:
                                                              buttonTextColor),
                                                ),
                                              ),
                                              const Gap(10.0),
                                              Text(
                                                textAlign: TextAlign.left,
                                                "Connect With Us",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: buttonTextColor),
                                              ),
                                              const Gap(10.0),
                                              Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        ContactFeatures()
                                                            .launchInstagram(
                                                                context,
                                                                supportViewController
                                                                    .contactUsDataModel
                                                                    .data!
                                                                    .instagramID
                                                                    .toString()
                                                                    .split(
                                                                        "/")[3]);
                                                      },
                                                      child: SvgPicture.asset(
                                                        "assets/svg/instaSvg.svg",
                                                        color: Colors.white,
                                                      )),
                                                  const Gap(10.0),
                                                  InkWell(
                                                    onTap: () {
                                                      ContactFeatures().launchFacebook(
                                                          context,
                                                          supportViewController
                                                              .contactUsDataModel
                                                              .data!
                                                              .fbID
                                                              .toString()
                                                              .split("/")[4]
                                                              .replaceAll(
                                                                  "-", ""));
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/svg/fbSvg.svg",
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const Gap(10.0),
                                                  InkWell(
                                                    onTap: () {
                                                      ContactFeatures().launchYoutube(
                                                          context,
                                                          supportViewController
                                                              .contactUsDataModel
                                                              .data!
                                                              .ytChannelID
                                                              .toString()
                                                              .split("/")[3]);
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/svg/youtubeSvg.svg",
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Gap(10.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      );
              },
            )),
      ),
    );
  }

  Positioned searchSectionsHome(
      Size size, HomeVIewController homeViewController) {
    return Positioned(
      top: size.width >= 640 ? size.height * 0.35 : size.height * 0.21,
      right: 15,
      left: 15,
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(
          //     context, AppRoutes.mainFilter);
        },
        child: Container(
          width: size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: secondaryColor),
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<HomeVIewController>(
                builder: (context, homeViewController, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.width >= 640
                          ? size.height * 0.15
                          : size.height * 0.05,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.mainFilter,
                                  arguments: PassFilterModel(
                                      id: 0,
                                      logLate: "Buy",
                                      title: "Main Filter"),
                                );
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: textColor2.withOpacity(0.3),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 5.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Buy",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: textColor3,
                                          ),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.mainFilter,
                                  arguments: PassFilterModel(
                                      id: 0,
                                      logLate: "Rent",
                                      title: "Main Filter"),
                                );
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: textColor2.withOpacity(0.3),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 5.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Rent",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: textColor3,
                                          ),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                if (box.read("access_token_raipurHomes") ==
                                    "") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints.loose(
                                              const Size.fromHeight(400)),
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FadeInDown(
                                                  child: Stack(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 50,
                                                        backgroundColor:
                                                            secondaryColor,
                                                        child: CircleAvatar(
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
                                                        child: CircleAvatar(
                                                            radius: 18,
                                                            child: Icon(
                                                              Icons.close,
                                                              color: errorColor,
                                                              size: 18,
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
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              FadeInLeft(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  'Log in to enjoy all the features and a customized experience.',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: subTitleColor),
                                                ),
                                              ),
                                              const Gap(20),
                                              FadeInDown(
                                                child: CustomButton(
                                                    onTap: () => Navigator
                                                            .pushNamedAndRemoveUntil(
                                                          context,
                                                          AppRoutes.loginNumber,
                                                          (route) => false,
                                                        ),
                                                    title: "Yes, Login"),
                                              ),
                                              const Gap(10),
                                              FadeInUp(
                                                child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    'Not Now',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: errorColor),
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
                                  Navigator.pushNamed(
                                          context, AppRoutes.postProperty)
                                      .whenComplete(
                                    () {
                                      final imageController =
                                          context.read<GetImageFromUser>();
                                      imageController.removeImage();
                                    },
                                  );
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: textColor2.withOpacity(0.3),
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Sell",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: textColor3,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(2.0),
                          //   child: Container(
                          //       alignment: Alignment.center,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           // border: Border.all(width: 1),
                          //           borderRadius:
                          //               BorderRadius.circular(8.0),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: secondaryColor
                          //                   .withOpacity(0.3),
                          //               blurRadius: 2,
                          //               offset: const Offset(0, 1),
                          //             ),
                          //           ]),
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 15.0, vertical: 5.0),
                          //         child: Text(
                          //           textAlign: TextAlign.center,
                          //           "Agriland",
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .labelSmall!
                          //               .copyWith(
                          //                 color: textColor2,
                          //               ),
                          //         ),
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Padding(
              //     padding:
              //         const EdgeInsets.all(8.0),
              //     child: Consumer<
              //         PopularLocationPropertyListViewModal>(
              //       builder:
              //           (context, value, child) {
              //         return CustomTextInputForSearchHome(
              //           onTap: () {
              //             // context
              //             //     .read<
              //             //         MainHomeViewViewModal>()
              //             //     .setKeyboardOn(false);
              //           },
              //           hintText:
              //               "Search here.....",
              //           isEnableVoice:
              //               value.isVoiceEnable,
              //           controller:
              //               _searchController,
              //           onTapSearch: () {
              //             if (_searchController
              //                 .text.isNotEmpty) {
              //               Navigator.pushNamed(
              //                   context,
              //                   AppRoutes
              //                       .popularLocationPropertyList,
              //                   arguments:
              //                       _searchController
              //                           .text
              //                           .toString());
              //             } else {
              //               Utils.toastMessage(
              //                   "Please fill your search on SearchBox",
              //                   warningColor);
              //             }
              //           },
              //
              //           onTapVoice: () {
              //             _showVoiceSpeedDialog(
              //                 value);
              //             value
              //                 .setVoiceEnable(true);
              //             if (value.isAvailable) {
              //               _speechToText.listen(
              //                 onResult: (result) {
              //                   if (kDebugMode) {
              //                     print(
              //                         "Voice recognized: ${result.recognizedWords}");
              //                   }
              //                   // if (_searchController.text.isNotEmpty) {
              //                   //   voiceText = voiceText + " " + result.recognizedWords;
              //                   //   _searchController.text = voiceText;
              //                   // } else {
              //                   //
              //                   // }
              //                   voiceText = result
              //                       .recognizedWords;
              //                   _searchController
              //                           .text =
              //                       voiceText;
              //                 },
              //               );
              //             }
              //           },
              //         );
              //       },
              //     )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: searchBar(homeViewController, _searchController),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container searchBar(HomeVIewController homeViewController,
      TextEditingController searchController) {
    final LayerLink _layerLink = LayerLink();
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<PopularLocationPropertyListViewModal>(
        builder: (context, value, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return homeViewController.suggestionTextModel.data!
                            .where((word) => word
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (option) {
                        print("The $option was selected");
                        searchController.text = option.toString();

                        setState(() {});
                        Navigator.pushNamed(
                          context,
                          AppRoutes.mainFilter,
                          arguments: PassFilterModel(
                              id: 4,
                              logLate: option.toString(),
                              title: "Main Filter"),
                        ).whenComplete(() =>
                            context.read<GetFilterTools>().clearAllFilters());
                        context.read<GetFilterTools>().setSearchKeyword(
                            _searchController.text.toString() ?? "");
                        KeyboardUtils.unFocus(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onSubmitted) {
                        // if (searchController.text.isNotEmpty) {
                        //   controller = searchController;
                        // } else {
                        //   searchController = controller;
                        // }
                        controller.text = searchController.text;
                        controller.addListener(() {
                          searchController.text = controller.text;
                        });
                        return TextFormField(
                          style: Theme.of(context).textTheme.labelSmall,
                          controller: controller,
                          focusNode: focusNode,
                          // onChanged: (value) {
                          //   if (searchController.text.isEmpty) {
                          //     searchController.clear();
                          //   } else {
                          //     searchController.text = value;
                          //   }
                          // },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search here.....',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      },
                      optionsViewOpenDirection: OptionsViewOpenDirection.down,
                      optionsViewBuilder: (context, onSelected, options) {
                        return CompositedTransformFollower(
                          link: _layerLink,
                          showWhenUnlinked: false,
                          offset: const Offset(-35, 50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white),
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      overflow: TextOverflow.visible,
                                      options.elementAt(index),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    onTap: () {
                                      onSelected(options.elementAt(index));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (searchController.text.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.mainFilter,
                        arguments: PassFilterModel(
                            id: 4,
                            logLate: searchController.text.toString(),
                            title: "Main Filter"),
                      ).whenComplete(() =>
                          context.read<GetFilterTools>().clearAllFilters());
                      context.read<GetFilterTools>().setSearchKeyword(
                          _searchController.text.toString() ?? "");
                    } else {
                      Utils.toastMessage(
                          "Please enter any search words", warningColor);
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: textColor3.withOpacity(0.1)),
                    child: Icon(
                      Icons.search,
                      color: accentColor,
                    ),
                  )),
              const Gap(5.0),
              Container(
                height: 40,
                width: 1,
                color: Colors.black26,
              ),
              const Gap(5.0),
              GestureDetector(
                  onTap: () {
                    if (homeViewController.isScanning) {
                      searchController.text = "Searching location";
                    }
                    homeViewController.setIsScanning(false);
                    if (homeViewController.isScanning == false) {
                      searchController.clear();
                    }
                    homeViewController.checkPermission();
                    searchController.text =
                        homeViewController.address.replaceAll(",", "");
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: textColor3.withOpacity(0.1),
                    child: Icon(
                      Icons.my_location,
                      color: accentColor,
                    ),
                  )),
              const Gap(10.0),
              GestureDetector(
                  onTap: () {
                    _showVoiceSpeedDialog(value);
                    value.setVoiceEnable(true);
                    if (value.isAvailable) {
                      _speechToText.listen(
                        onResult: (result) {
                          if (kDebugMode) {
                            print(
                                "Voice recognized: ${result.recognizedWords}");
                          }
                          // if (_searchController.text.isNotEmpty) {
                          //   voiceText = voiceText + " " + result.recognizedWords;
                          //   _searchController.text = voiceText;
                          // } else {
                          //
                          // }
                          voiceText = result.recognizedWords;
                          searchController.text = voiceText;
                          setState(() {});
                        },
                      );
                    }
                  },
                  child: AvatarGlow(
                      animate: value.isVoiceEnable == false ? false : true,
                      glowColor: value.isVoiceEnable == false
                          ? Colors.white
                          : textColor3,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: textColor3.withOpacity(0.1),
                        child: Icon(
                          Icons.mic,
                          color: accentColor,
                        ),
                      ))),
              const Gap(10.0)
            ],
          );
        },
      ),
    );
  }
}

// FadeInLeft(
//   child: HomeTitlesHeading(
//     title: "Recommended Property",
//     subtitle: "View all",
//     onTap: () {
//       Navigator.pushNamed(
//           context, AppRoutes.popularLocations,
//           arguments: PopularAllListArgsModal(
//               "Recommended Property",
//               "recommendedProperty"));
//     },
//   ),
// ),
// SizedBox(
//   height: size.height * 0.23,
//   child: ListView.builder(
//     padding: EdgeInsets.zero,
//     scrollDirection: Axis.horizontal,
//     itemCount: 10,
//     itemBuilder: (context, index) {
//       return FadeInRight(
//         child: RecommendedPropertyCard(
//           size: size,
//           image: "assets/images/onBoardImage1.jpg",
//           propertyTitle: "Siddhi Atlantis",
//           subtitle:
//               "2,3,4 BHK Apartment in Avanti Vihar, Raipur",
//         ),
//       );
//     },
//   ),
// ),
// FadeInLeft(
//   child: HomeTitlesHeading(
//     title: "Hand Picked Property",
//     subtitle: "View all",
//     onTap: () {
//       Navigator.pushNamed(
//           context, AppRoutes.popularLocations,
//           arguments: PopularAllListArgsModal(
//               "Hand Picked Property",
//               "handPickedProperty"));
//     },
//   ),
// ),
// SizedBox(
//   height: size.height * 0.4,
//   child: ListView.builder(
//     padding: EdgeInsets.zero,
//     scrollDirection: Axis.horizontal,
//     itemCount: 5,
//     itemBuilder: (context, index) {
//       return FadeInRight(
//         child: HandPickedPropertyCard(
//             size: size,
//             image: "assets/images/onBoardImage3.jpg",
//             propertyName: 'Exquisite Estate',
//             locations:
//                 'Near Currency Tower VIP Road,Raipur',
//             price: '25000'),
//       );
//     },
//   ),
// ),
// FadeInLeft(
//   child: HomeTitlesHeading(
//     title: "RH Exclusive",
//     subtitle: "View all",
//     onTap: () {
//       Navigator.pushNamed(
//           context, AppRoutes.popularLocations,
//           arguments: PopularAllListArgsModal(
//               pageTitle: "RH Exclusive",
//               category: "rhExclusive",
//               pageType: "exclusive"));
//     },
//   ),
// ),
// SizedBox(
//   height: size.height * 0.18,
//   child: ListView.builder(
//     padding: EdgeInsets.zero,
//     scrollDirection: Axis.horizontal,
//     itemCount: 10,
//     itemBuilder: (context, index) {
//       return FadeInRight(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: size.height * 0.18,
//             width: size.height * 0.25,
//             decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(16.0),
//                 image: const DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage(
//                         "assets/images/exclusiveBanner.jpg"))),
//           ),
//         ),
//       );
//     },
//   ),
// ),
// FadeInLeft(
//   child: const HomeTitlesHeading(
//     title: "Demand In City",
//   ),
// ),
// SizedBox(
//   height: size.height * 0.27,
//   child: ListView.builder(
//     padding: EdgeInsets.zero,
//     scrollDirection: Axis.horizontal,
//     itemCount: 4,
//     itemBuilder: (context, index) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           height: size.height * 0.15,
//           width: size.height * 0.28,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 3,
//                 offset: const Offset(0, 2),
//               )
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "Apartment",
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelMedium!
//                       .copyWith(
//                           color: textColor2,
//                           fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     physics:
//                         const NeverScrollableScrollPhysics(),
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding:
//                             const EdgeInsets.all(2.0),
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                           children: [
//                             Text(
//                               "${index + 1} ${apartmentList[index]}",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelSmall!
//                                   .copyWith(
//                                     color: textColor2,
//                                   ),
//                             ),
//                             Text(
//                               "12 % Searches",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelSmall!
//                                   .copyWith(
//                                       color:
//                                           subTitleColor,
//                                       fontSize: 12.0),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 Text(
//                   "View all localities",
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelSmall!
//                       .copyWith(color: textColor3),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   ),
// ),
// FadeInLeft(
//   child: const HomeTitlesHeading(
//     title: "Popular Constructor",
//   ),
// ),
// SizedBox(
//   height: size.height * 0.17,
//   child: ListView.builder(
//     controller: _scrollController2,
//     padding: EdgeInsets.zero,
//     physics: const BouncingScrollPhysics(),
//     scrollDirection: Axis.horizontal,
//     itemCount: 10,
//     itemBuilder: (context, index) {
//       return FadeInRight(
//         child: PopularConstructorCard(
//           size: size,
//           name: 'Raipur Homes',
//           image: "assets/png/rprNewLogo.png",
//           totalProjects: '15',
//         ),
//       );
//     },
//   ),
// ),
