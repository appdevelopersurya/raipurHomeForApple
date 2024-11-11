import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/Skeletons/GridSkeleton.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/PopularAllListArgModal.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/Home/viewModal/homeViewController.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/screens/SubPages/PostProperty/viewModel/postPropertyViewModel.dart';
import 'package:fmraipuromes/utils/CustomTextInput.dart';
import 'package:fmraipuromes/utils/FeaturedPropertyCard.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:fmraipuromes/utils/RecommendedPropertyCard.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/popularPropertyCard.dart';
import 'package:fmraipuromes/utils/popularlocation.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../constant/appText.dart';
import '../../../../data/modal/passFilterModel.dart';
import '../../../../repository/getFilterTools.dart';
import '../../../../utils/CustomButton.dart';
import '../../../../utils/HandPickedPropertyCard.dart';

class PopularAllList extends StatefulWidget {
  final PopularAllListArgsModal allListArgsModal;

  const PopularAllList({
    super.key,
    required this.allListArgsModal,
  });

  @override
  State<PopularAllList> createState() => _PopularAllListState();
}

class _PopularAllListState extends State<PopularAllList> {
  final TextEditingController _searchController = TextEditingController();

  _firstLoad() async {
    final popularLocationPropertyListViewModal =
        Provider.of<PopularLocationPropertyListViewModal>(context,
            listen: false);

    if (mounted) {
      if (widget.allListArgsModal.category == "searchText") {
        if (widget.allListArgsModal.pageType == "allProperties") {
          var body = {
            "searchInput": widget.allListArgsModal.pageTitle.toString(),
            // "searchInput": "Mowa",
          };
          if (kDebugMode) {
            print("body data===> $body");
          }
          popularLocationPropertyListViewModal.getActualFilterProperty(body);
        }
      } else {
        if (widget.allListArgsModal.pageType == "allProperties") {
          print("api calling--------->");
          popularLocationPropertyListViewModal
              .getAllPropertyList(widget.allListArgsModal.category.toString());
        } else {
          popularLocationPropertyListViewModal.getUserProperty(false);
        }
      }
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
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
    final homeViewController = Provider.of<HomeVIewController>(context);
    final postProperty = Provider.of<PostPropertyViewModel>(context);
    final popularLocationPropertyListViewModal =
        Provider.of<PopularLocationPropertyListViewModal>(context);

    return Scaffold(
      appBar: widget.allListArgsModal.pageType == "allProperties" ||
              widget.allListArgsModal.pageType == "Buy" ||
              widget.allListArgsModal.pageType == "Rent"
          ? AppBar(
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
              title: popularLocationPropertyListViewModal.isSearchBox == true &&
                      popularLocationPropertyListViewModal.isFilter == false
                  ? CustomTextInputForSearch(
                      controller: _searchController,
                      hintText: 'Search here.....',
                      icon: CupertinoIcons.search,
                      keyboardType: TextInputType.text,
                      readOnly: false,
                      onTap: () {
                        var body = {
                          "searchInput": _searchController.text.toString(),
                        };
                        if (kDebugMode) {
                          print("filter body ====> $body");
                        }
                        popularLocationPropertyListViewModal
                            .getActualFilterProperty(body);
                      },
                    )
                  : Text(
                      widget.allListArgsModal.pageTitle.toString(),
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
                    padding: const EdgeInsets.all(5.0),
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
                widget.allListArgsModal.pageType == "allProperties"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: borderColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.filterNew);
                              },
                              child: SvgPicture.asset(
                                "assets/svg/filterOn.svg",
                                color: textColor2,
                                height: 27,
                                width: 27,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Offstage(),
              ],
            )
          : NormalAppBar(
              title: widget.allListArgsModal.pageTitle ?? "Page Title",
            ),
      body: widget.allListArgsModal.pageType == "location" &&
              popularLocationPropertyListViewModal.isLoading == true
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: const GridSkeleton())
          : widget.allListArgsModal.pageType == "location"
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount:
                      homeViewController.trendingAreaModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.popularLocationPropertyList,
                            arguments: PassFilterModel(
                                id: homeViewController
                                        .trendingAreaModel.data?[index].id ??
                                    0,
                                title: homeViewController
                                        .trendingAreaModel.data?[index].name
                                        .toString() ??
                                    "",
                                logLate: ""));
                        context.read<GetFilterTools>().setTownId(
                            homeViewController.trendingAreaModel.data?[index].id
                                    .toString() ??
                                "0");
                      },
                      child: FadeInDown(
                        child: PopularLocation(
                          image: homeViewController
                                  .trendingAreaModel.data?[index].image
                                  .toString() ??
                              "",
                          locationName: homeViewController
                                  .trendingAreaModel.data?[index].name
                                  .toString() ??
                              "",
                          // propertyQty: "4",
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 175),
                )
              : popularLocationPropertyListViewModal.isLoading == true
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade50,
                      child: const ListViewBuilderSkeleton())
                  : widget.allListArgsModal.pageType == "property"
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 10,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FadeInDown(
                              child: PopularPropertyCardForAll(
                                size: size,
                                image: "assets/images/popularPic.jpg",
                                propertyName: "Golden Fields Estates",
                                price: "16000",
                                bathrooms: "2",
                                bedrooms: "3",
                                Sqft: "2450",
                              ),
                            );
                          },
                        )
                      : widget.allListArgsModal.pageType ==
                              "recommendedProperty"
                          ? GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // Number of columns in the grid
                                childAspectRatio:
                                    0.8, // Aspect ratio of each grid item
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return FadeInDown(
                                  child: RecommendedPropertyCardAll(
                                    size: size,
                                    image: "assets/images/onBoardImage1.jpg",
                                    propertyTitle: "Siddhi Atlantis",
                                    subtitle:
                                        "2,3,4 BHK Apartment in Avanti Vihar, Raipur",
                                    price: "4599",
                                    type: "For Sale",
                                  ),
                                );
                              },
                            )
                          : widget.allListArgsModal.pageType ==
                                  "handPickedProperty"
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return FadeInDown(
                                      child: HandPickedPropertyCardAll(
                                          size: size,
                                          image:
                                              "assets/images/onBoardImage3.jpg",
                                          propertyName: 'Exquisite Estate',
                                          locations:
                                              'Near Currency Tower VIP Road,Raipur',
                                          price: '25000'),
                                    );
                                  },
                                )
                              : widget.allListArgsModal.pageType ==
                                      "rhExclusive"
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInDown(
                                            child: Container(
                                              height: size.height * 0.18,
                                              width: size.height * 0.25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  image: const DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "assets/images/exclusiveBanner.jpg"))),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : popularLocationPropertyListViewModal
                                              .isLoading ==
                                          true
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                          child:
                                              const ListViewBuilderSkeleton())
                                      : widget.allListArgsModal.pageType ==
                                              "allProperties"
                                          ? popularLocationPropertyListViewModal
                                                      .allPropertyModel
                                                      .data
                                                      ?.length ==
                                                  0
                                              ? Center(
                                                  child: Lottie.asset(
                                                      "assets/gif/noData.json"))
                                              : GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 10,
                                                    childAspectRatio: 0.60,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  itemCount:
                                                      popularLocationPropertyListViewModal
                                                              .allPropertyModel
                                                              .data
                                                              ?.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return FadeInDown(
                                                        child:
                                                            FeaturedPropertyGridCardForHome(
                                                      onTapShare: () {
                                                        Share.share(
                                                            "🏡 Property Title : \n${popularLocationPropertyListViewModal.allPropertyModel.data?[index].title.toString()}"
                                                            "\n📍 Location : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].jioLocation.toString()}"
                                                            "\n ₹ Price : ${NumberFormat.currency(
                                                          locale: 'HI',
                                                          symbol: AppText
                                                              .rupeeSymbol,
                                                        ).format(int.parse(popularLocationPropertyListViewModal.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                                            "\n📏 Size : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].size.toString()} SQFT"
                                                            "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                                            "\n\nCheck out through this link :"
                                                            "\nhttps://www.raipurhomes.com/property-details/${popularLocationPropertyListViewModal.allPropertyModel.data?[index].titleSlug.toString()}-${popularLocationPropertyListViewModal.allPropertyModel.data?[index].serviceId.toString()}");
                                                      },
                                                      onTap: () => Navigator.pushNamed(
                                                          context,
                                                          AppRoutes
                                                              .propertyDetailView,
                                                          arguments:
                                                              popularLocationPropertyListViewModal
                                                                  .allPropertyModel
                                                                  .data?[index]
                                                                  .serviceId
                                                                  .toString()),
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
                                                                symbol: AppText
                                                                    .rupeeSymbol,
                                                              ).format(int.parse(popularLocationPropertyListViewModal.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                                              "\n📏 Size : ${popularLocationPropertyListViewModal.allPropertyModel.data?[index].size.toString()} SQFT"
                                                              "\n\nProperty Link Here:"
                                                              "\nhttps://www.raipurhomes.com/property-details/${popularLocationPropertyListViewModal.allPropertyModel.data?[index].titleSlug.toString()}-${popularLocationPropertyListViewModal.allPropertyModel.data?[index].serviceId.toString()}"),
                                                      views: popularLocationPropertyListViewModal
                                                              .allPropertyModel
                                                              .data?[index]
                                                              .visitCount
                                                              .toString() ??
                                                          "",
                                                      size: size,
                                                      forSale: popularLocationPropertyListViewModal
                                                              .allPropertyModel
                                                              .data?[index]
                                                              .getapiCategories
                                                              ?.categoriesName
                                                              .toString() ??
                                                          "",
                                                      type: popularLocationPropertyListViewModal
                                                              .allPropertyModel
                                                              .data?[index]
                                                              .getapiPropertySubType
                                                              ?.name
                                                              .toString() ??
                                                          "",
                                                      price: popularLocationPropertyListViewModal
                                                              .allPropertyModel
                                                              .data?[index]
                                                              .pricing
                                                              .toString() ??
                                                          "",
                                                      title: popularLocationPropertyListViewModal
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
                                                      imageList: [] ?? [],
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
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  constraints: BoxConstraints.loose(
                                                                      const Size
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
                                                                          onPressed: () =>
                                                                              Navigator.pop(context),
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            'Not Now',
                                                                            style:
                                                                                Theme.of(context).textTheme.labelSmall!.copyWith(color: errorColor),
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
                                                          popularLocationPropertyListViewModal.setIsFav(
                                                              popularLocationPropertyListViewModal
                                                                      .allPropertyModel
                                                                      .data?[
                                                                          index]
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
                                                      isFavorite: popularLocationPropertyListViewModal
                                                                  .allPropertyModel
                                                                  .data?[index]
                                                                  .getBookMarkedProperty !=
                                                              null
                                                          ? true
                                                          : false,
                                                      subType: popularLocationPropertyListViewModal
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
                                                    ));
                                                  },
                                                )
                                          : widget.allListArgsModal.pageType ==
                                                  "myProperty"
                                              ? popularLocationPropertyListViewModal
                                                          .getUserPropertyDataModel
                                                          .data
                                                          ?.length ==
                                                      0
                                                  ? Center(
                                                      child: Lottie.asset(
                                                          "assets/gif/noData.json"))
                                                  : ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      padding: EdgeInsets.zero,
                                                      itemCount:
                                                          popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data
                                                                  ?.length ??
                                                              0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        print(
                                                            "imagesss=========> ${popularLocationPropertyListViewModal.getUserPropertyDataModel.data?[index].propertyImage ?? ""}");
                                                        return FadeInDown(
                                                            child:
                                                                FeaturedPropertyCardForMyProperty(
                                                          onTapDelete:
                                                              () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                title: Text(
                                                                  'Confirm',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall,
                                                                ),
                                                                content: Text(
                                                                  'Are you sure do you want to delete your post property ?',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelMedium,
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(false),
                                                                    child: Text(
                                                                      'No',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelMedium,
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      customFutureLoader(
                                                                        context:
                                                                            context,
                                                                        future: () =>
                                                                            postProperty.deleteProperty(popularLocationPropertyListViewModal.getUserPropertyDataModel.data?[index].id.toString() ??
                                                                                ""),
                                                                      ).then(
                                                                        (value) {
                                                                          Utils.toastMessage(
                                                                              "Property Deleted Successfully",
                                                                              successColor);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelMedium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ).whenComplete(
                                                              () =>
                                                                  _firstLoad(),
                                                            );
                                                          },
                                                          views: "",
                                                          size: size,
                                                          forSale: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .categories
                                                                  .toString() ??
                                                              "",
                                                          type: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .type
                                                                  .toString() ??
                                                              "",
                                                          price: "",
                                                          title: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .title
                                                                  .toString() ??
                                                              "",
                                                          address: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .address
                                                                  .toString() ??
                                                              "",
                                                          imageList: [] ?? [],
                                                          featureImage: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .propertyImage
                                                                  .toString() ??
                                                              "",
                                                          priceType: "",
                                                          isFavorite: false,
                                                          subType: popularLocationPropertyListViewModal
                                                                  .getUserPropertyDataModel
                                                                  .data?[index]
                                                                  .propertyType
                                                                  .toString() ??
                                                              "",
                                                        ));
                                                      },
                                                    )
                                              : const Offstage(),
    );
  }
}
