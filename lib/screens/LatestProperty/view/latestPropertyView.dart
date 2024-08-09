import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/LatestProperty/viewModel/latestPropertyController.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/appText.dart';
import '../../../constant/color.dart';
import '../../../utils/FeaturedPropertyCard.dart';
import '../../Drawer/view/mainDrawerNew.dart';

class LatestPropertyView extends StatefulWidget {
  const LatestPropertyView({super.key});

  @override
  State<LatestPropertyView> createState() => _LatestPropertyViewState();
}

class _LatestPropertyViewState extends State<LatestPropertyView> {
  Future _onRefresh() {
    return _firstLoad();
  }

  _firstLoad() async {
    final latestPropertyController =
        Provider.of<LatestPropertyController>(context, listen: false);
    if (mounted) {
      latestPropertyController.getLatestProperty(false);
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final latestPropertyController =
        Provider.of<LatestPropertyController>(context);
    final mainHomeController = Provider.of<MainHomeViewViewModal>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        mainHomeController.changeIndexAccordingScreen(0);
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
          drawer: const MainDrawerNew(),
          key: _scaffoldKey,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFffffff),
                    Color(0xFFf3ef66),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // backgroundColor: secondaryColor,
            elevation: 1,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(13.0),
              child: InkWell(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: Icon(
                    Icons.menu,
                    color: textColor2,
                  )),
            ),
            title: Text(
              "Latest Properties",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: textColor2),
            ),
          ),
          body: latestPropertyController.isLoading == true
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade50,
                  child: const ListViewBuilderSkeleton())
              : latestPropertyController.allPropertyModel.data?.length == 0
                  ? Center(child: Lottie.asset("assets/gif/noData.json"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: latestPropertyController
                              .allPropertyModel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return FadeInDown(
                            child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.propertyDetailView,
                              arguments: latestPropertyController
                                  .allPropertyModel.data?[index].serviceId),
                          child: FeaturedPropertyCardForHome(
                            onTapShare: () {
                              Share.share(
                                  "🏡 Property Title : \n${latestPropertyController.allPropertyModel.data?[index].title.toString()}"
                                  "\n📍 Location : ${latestPropertyController.allPropertyModel.data?[index].jioLocation.toString()}"
                                  "\n ₹ Price : ${NumberFormat.currency(
                                locale: 'HI',
                                symbol: AppText.rupeeSymbol,
                              ).format(int.parse(latestPropertyController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                  "\n📏 Size : ${latestPropertyController.allPropertyModel.data?[index].size.toString()} SQFT"
                                  "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                  "\n\nCheck out though this link :"
                                  "\nhttps://play.google.com/store/apps/details?id=com.raipurHomes");
                            },
                            onTapFavorite: () {
                              if (box.read("access_token_raipurHomes") == "") {
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
                                latestPropertyController.setIsFav(
                                    latestPropertyController.allPropertyModel
                                            .data?[index].serviceId
                                            .toString() ??
                                        "",
                                    index);
                              }
                            },
                            isLoading: latestPropertyController
                                .allPropertyModel.data?[index].loading,
                            isFavorite: latestPropertyController
                                        .allPropertyModel
                                        .data?[index]
                                        .getBookMarkedProperty !=
                                    null
                                ? true
                                : false,
                            onTapCall: () async => await ContactFeatures()
                                .launchCalling(
                                    context,
                                    latestPropertyController.allPropertyModel
                                            .adminDetails?.adminNumber
                                            .toString() ??
                                        ""),
                            onTapWhatsapp: () async => await ContactFeatures()
                                .launchWhatsapp(
                                    context,
                                    latestPropertyController.allPropertyModel
                                            .adminDetails?.adminWhatsappNumber
                                            .toString() ??
                                        "",
                                    "Hii i am interested in this property"
                                    "\n\n🏡 Property Title : \n${latestPropertyController.allPropertyModel.data?[index].title.toString()}"
                                    "\n📍 Location : ${latestPropertyController.allPropertyModel.data?[index].jioLocation.toString()}"
                                    "\n ₹ Price : ${NumberFormat.currency(
                                      locale: 'HI',
                                      symbol: AppText.rupeeSymbol,
                                    ).format(int.parse(latestPropertyController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                    "\n📏 Size : ${latestPropertyController.allPropertyModel.data?[index].size.toString()} SQFT"),
                            views: latestPropertyController
                                    .allPropertyModel.data?[index].visitCount
                                    .toString() ??
                                "",
                            size: size,
                            forSale: latestPropertyController
                                    .allPropertyModel
                                    .data?[index]
                                    .getapiCategories
                                    ?.categoriesName
                                    .toString() ??
                                "",
                            type: latestPropertyController.allPropertyModel
                                    .data?[index].getapiPropertySubType?.name
                                    .toString() ??
                                "",
                            price: latestPropertyController
                                    .allPropertyModel.data?[index].pricing
                                    .toString() ??
                                "",
                            title: latestPropertyController
                                    .allPropertyModel.data?[index].title
                                    .toString() ??
                                "",
                            address: latestPropertyController
                                    .allPropertyModel.data?[index].address
                                    .toString() ??
                                "",
                            imageList: [] ?? [],
                            featureImage: latestPropertyController
                                    .allPropertyModel
                                    .data?[index]
                                    .featureImage ??
                                "",
                            priceType: latestPropertyController
                                    .allPropertyModel.data?[index].pricetype
                                    .toString() ??
                                "",
                            constructionSize: latestPropertyController
                                    .allPropertyModel.data?[index].size
                                    .toString() ??
                                "",
                            propertyFace: parsePropertyFace(
                                latestPropertyController.allPropertyModel
                                        .data?[index].propertyface
                                        .toString() ??
                                    ""),
                            openSide: latestPropertyController
                                    .allPropertyModel.data?[index].openside
                                    .toString() ??
                                "",
                            subType: latestPropertyController.allPropertyModel
                                    .data?[index].getapiPropertyType?.name
                                    .toString() ??
                                "",
                            floorType: latestPropertyController
                                    .allPropertyModel.data?[index].floortype
                                    .toString() ??
                                "",
                            flatType: latestPropertyController
                                    .allPropertyModel.data?[index].flattype
                                    .toString() ??
                                "",
                            propertyInterior: latestPropertyController
                                    .allPropertyModel
                                    .data?[index]
                                    .propertyinterior
                                    .toString() ??
                                "",
                          ),
                        ));
                      },
                    ),
        ),
      ),
    );
  }
}
