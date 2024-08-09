import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/utils/CustomTextInput.dart';
import 'package:fmraipuromes/utils/FeaturedPropertyCard.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../constant/appText.dart';
import '../../../../constant/color.dart';
import '../../../../utils/CustomButton.dart';
import '../../PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';

class MainFilter extends StatefulWidget {
  final PassFilterModel passFilterModel;

  const MainFilter({super.key, required this.passFilterModel});

  @override
  State<MainFilter> createState() => _MainFilterState();
}

class _MainFilterState extends State<MainFilter> {
  TextEditingController _searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  var voiceText;

  filterDataCalling() async {
    var body;
    final filterController =
        Provider.of<GetFilterTools>(context, listen: false);

    print(
        "search input data ===> ${filterController.searchKeyword.toString()}");

    print("town id data ===> ${filterController.townId.toString()}");
    if (widget.passFilterModel.id == 5) {
      print("buy filter");
      body = {
        "category": filterController.isVerified.toString() ?? "",
      };
    } else if (widget.passFilterModel.id == 3) {
      body = {
        "category": filterController.isVerified.toString() ?? "",
      };
    } else if (widget.passFilterModel.id == 4) {
      print("search filter");
      body = {"searchInput": "${widget.passFilterModel.logLate.toString()}"};
    } else if (widget.passFilterModel.logLate == "Buy") {
      print("direct buy filter");
      body = {"category": "5"};
    } else if (widget.passFilterModel.logLate == "cat") {
      print("direct cat filter");
      body = {"type": "[${widget.passFilterModel.id}]"};
    } else if (widget.passFilterModel.logLate == "Rent") {
      print("direct rent filter");
      body = {"category": "3"};
    } else if (widget.passFilterModel.logLate == "onlyProperty") {
      print("direct onlyProperty filter");
      body = {"property_type": "[${widget.passFilterModel.id}]"};
    } else if (widget.passFilterModel.logLate == "onlySubType") {
      print("direct onlyProperty filter");
      body = {"type": "[${widget.passFilterModel.id}]"};
    } else if (widget.passFilterModel.logLate == "onlyBuilder") {
      print("direct onlyBuilder filter");
      body = {"builder": "[${widget.passFilterModel.id}]"};
    } else if (widget.passFilterModel.logLate == "singleLocation") {
      print("direct singleLocation filter");
      body = {"current_area": "${widget.passFilterModel.id}"};
    } else {
      print("rent filter");
      if (filterController.isVerified == 5) {
        body = {
          "category": filterController.isVerified.toString() ?? "",
          "min_price": filterController.priceRangeValueBuy1.toString() ?? "",
          "max_price": filterController.priceRangeValueBuy2.toString() ?? "",
          // "current_area": "${widget.passFilterModel.id}" ?? "",
          "location": filterController.selectedAreas.length == 0
              ? ""
              : "${filterController.selectedAreas}",
          "property_type": filterController.selectedPropertyType.length == 0
              ? ""
              : "${filterController.selectedPropertyType}",
          "type": filterController.selectedSubPropertyType.length == 0
              ? ""
              : "${filterController.selectedSubPropertyType}",
          "builder": filterController.selectedByBuilder.length == 0
              ? ""
              : "${filterController.selectedByBuilder ?? ""}",
          "bhk_type": filterController.selectedBHKType.length == 0
              ? ""
              : "${filterController.selectedBHKType}",
          "construction_status":
              filterController.selectedConstructionType.length == 0
                  ? ""
                  : "${filterController.selectedConstructionType}",
          "property_interior":
              filterController.selectedPropertyInterior.length == 0
                  ? ""
                  : "${filterController.selectedPropertyInterior}",
          "min_size": filterController.areaRangeValue1.toString() ?? "",
          "max_size": filterController.areaRangeValue2.toString() ?? "",
          "areaRangeKm1": filterController.areaRangeKm1.toString() ?? "",
          "areaRangeKm2": filterController.areaRangeKm2.toString() ?? "",
          "current_area": filterController.townId.toString() ?? "",
          "searchInput": filterController.searchKeyword.toString() ?? "",
        };
      } else {
        body = {
          "category": filterController.isVerified.toString() ?? "",
          "min_price": filterController.priceRangeValueRent1.toString() ?? "",
          "max_price": filterController.priceRangeValueRent2.toString() ?? "",
          // "current_area": "${widget.passFilterModel.id}" ?? "",
          "location": filterController.selectedAreas.length == 0
              ? ""
              : "${filterController.selectedAreas}",
          "property_type": filterController.selectedPropertyType.length == 0
              ? ""
              : "${filterController.selectedPropertyType}",
          "type": filterController.selectedSubPropertyType.length == 0
              ? ""
              : "${filterController.selectedSubPropertyType}",
          "builder": filterController.selectedByBuilder.length == 0
              ? ""
              : "${filterController.selectedByBuilder ?? ""}",
          "bhk_type": filterController.selectedBHKType.length == 0
              ? ""
              : "${filterController.selectedBHKType}",
          "construction_status":
              filterController.selectedConstructionType.length == 0
                  ? ""
                  : "${filterController.selectedConstructionType}",
          "property_interior":
              filterController.selectedPropertyInterior.length == 0
                  ? ""
                  : "${filterController.selectedPropertyInterior}",
          "min_size": filterController.areaRangeValue1.toString() ?? "",
          "max_size": filterController.areaRangeValue2.toString() ?? "",
          "areaRangeKm1": filterController.areaRangeKm1.toString() ?? "",
          "areaRangeKm2": filterController.areaRangeKm2.toString() ?? "",
          "current_area": filterController.townId.toString() ?? "",
          "searchInput": filterController.searchKeyword.toString() ?? "",
        };
      }
    }
    if (mounted) {
      print("initial filter body===> $body");
      await filterController.fetchFilteredData(body);
      print(
          "data length ====> ${filterController.allPropertyModel.data?.length}");
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

  @override
  void initState() {
    filterDataCalling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<GetFilterTools>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
        // backgroundColor: textColor5,
        elevation: 1,
        centerTitle: true,
        title: Consumer<PopularLocationPropertyListViewModal>(
          builder: (context, value, child) {
            return CustomTextInputForSearch(
                controller: _searchController,
                hintText: 'Search filter....',
                icon: CupertinoIcons.search,
                keyboardType: TextInputType.text,
                readOnly: false,
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.mainFilter,
                      arguments: PassFilterModel(
                          id: 4,
                          logLate: _searchController.text.toString(),
                          title: "Main Filter"),
                    );
                  }
                });
          },
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: textColor2,
          ),
        ),
        actions: [
          Padding(
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
              ),
            ),
          )
        ],
      ),
      body: filterController.isLoading == true
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: const ListViewBuilderSkeleton())
          : filterController.allPropertyModel.data?.length == 0
              ? Center(child: Lottie.asset("assets/gif/noData.json"))
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount:
                      filterController.allPropertyModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      child: FeaturedPropertyCardForHome(
                        onTapShare: () {
                          Share.share(
                              "🏡 Property Title : \n${filterController.allPropertyModel.data?[index].title.toString()}"
                              "\n📍 Location : ${filterController.allPropertyModel.data?[index].jioLocation.toString()}"
                              "\n ₹ Price : ${NumberFormat.currency(
                            locale: 'HI',
                            symbol: AppText.rupeeSymbol,
                          ).format(int.parse(filterController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                              "\n📏 Size : ${filterController.allPropertyModel.data?[index].size.toString()} SQFT"
                              "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                              "\n\nCheck out though this link :"
                              "\nhttps://play.google.com/store/apps/details?id=com.raipurHomes");
                        },
                        onTapCall: () async => await ContactFeatures()
                            .launchCalling(
                                context,
                                filterController.allPropertyModel.adminDetails
                                        ?.adminNumber
                                        .toString() ??
                                    ""),
                        onTapWhatsapp: () async => await ContactFeatures()
                            .launchWhatsapp(
                                context,
                                filterController.allPropertyModel.adminDetails
                                        ?.adminWhatsappNumber
                                        .toString() ??
                                    "",
                                "Hii i am interested in this property"
                                "\n\n🏡 Property Title : \n${filterController.allPropertyModel.data?[index].title.toString()}"
                                "\n📍 Location : ${filterController.allPropertyModel.data?[index].jioLocation.toString()}"
                                "\n ₹ Price : ${NumberFormat.currency(
                                  locale: 'HI',
                                  symbol: AppText.rupeeSymbol,
                                ).format(int.parse(filterController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                "\n📏 Size : ${filterController.allPropertyModel.data?[index].size.toString()} SQFT"),
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.propertyDetailView,
                            arguments: filterController
                                .allPropertyModel.data?[index].serviceId
                                .toString()),
                        views: filterController
                                .allPropertyModel.data?[index].visitCount
                                .toString() ??
                            "",
                        size: size,
                        forSale: filterController.allPropertyModel.data?[index]
                                .getapiCategories?.categoriesName
                                .toString() ??
                            "",
                        type: filterController.allPropertyModel.data?[index]
                                .getapiPropertySubType?.name
                                .toString() ??
                            "",
                        price: filterController
                                .allPropertyModel.data?[index].pricing
                                .toString() ??
                            "",
                        title: filterController
                                .allPropertyModel.data?[index].title
                                .toString() ??
                            "",
                        address: filterController
                                .allPropertyModel.data?[index].address
                                .toString() ??
                            "",
                        imageList: filterController
                                .allPropertyModel.data?[index].getapiimages ??
                            [],
                        featureImage: filterController
                                .allPropertyModel.data?[index].featureImage ??
                            "",
                        priceType: filterController
                                .allPropertyModel.data?[index].pricetype
                                .toString() ??
                            "",
                        constructionSize: filterController
                                .allPropertyModel.data?[index].size
                                .toString() ??
                            "",
                        propertyFace: parsePropertyFace(filterController
                                .allPropertyModel.data?[index].propertyface
                                .toString() ??
                            ""),
                        openSide: filterController
                                .allPropertyModel.data?[index].openside
                                .toString() ??
                            "",
                        onTapFavorite: () {
                          if (box.read("access_token_raipurHomes") == "") {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
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
                                          padding: const EdgeInsets.all(8.0),
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
                                                .copyWith(color: subTitleColor),
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
                            filterController.setIsFav(
                                filterController
                                        .allPropertyModel.data?[index].serviceId
                                        .toString() ??
                                    "",
                                index);
                          }
                        },
                        isLoading: filterController
                            .allPropertyModel.data?[index].loading,
                        isFavorite: filterController.allPropertyModel
                                    .data?[index].getBookMarkedProperty !=
                                null
                            ? true
                            : false,
                        subType: filterController.allPropertyModel.data?[index]
                                .getapiPropertyType?.name
                                .toString() ??
                            "",
                        floorType: filterController
                                .allPropertyModel.data?[index].floortype
                                .toString() ??
                            "",
                        flatType: filterController
                                .allPropertyModel.data?[index].flattype
                                .toString() ??
                            "",
                        propertyInterior: filterController
                                .allPropertyModel.data?[index].propertyinterior
                                .toString() ??
                            "",
                      ),
                    );
                  },
                ),
    );
  }
}
