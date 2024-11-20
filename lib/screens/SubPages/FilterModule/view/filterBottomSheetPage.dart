import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/appText.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/PriceModel.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/helper/amounFormatter.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/screens/Home/viewModal/homeViewController.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/utils/HomeTitlesHeading.dart';
import 'package:fmraipuromes/utils/KeyboardUtils.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // TextEditingController locSearchController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  dynamic voiceText;

  _fetchFilterData() {
    final filterController =
        Provider.of<GetFilterTools>(context, listen: false);
    if (mounted) {
      filterController.fetchFilterTools();
    }
  }

  @override
  void initState() {
    _fetchFilterData();
    super.initState();
  }

  // For Buy
  void showPriceBuyMinSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateBuyPriceList(
        int.parse(filterController.filterToolsDataModel.maxPrice.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Price',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setPriceMinValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Min Price===> ${filterController.priceMinTitle} - ${filterController.priceMinValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showPriceBuyMaxSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateBuyMaxPriceList(
        int.parse(filterController.filterToolsDataModel.maxPrice.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Price',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setPriceMaxValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Min Price===> ${filterController.priceMaxTitle} - ${filterController.priceMaxValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // For Rent
  void showPriceRentMinSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateRentPriceList(
        int.parse(filterController.filterToolsDataModel.maxPrice.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Price',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setPriceMinValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Min Price===> ${filterController.priceMinTitle} - ${filterController.priceMinValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showPriceRentMaxSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateRentMaxPriceList(
        int.parse(filterController.filterToolsDataModel.maxPrice.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Price',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setPriceMaxValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Min Price===> ${filterController.priceMaxTitle} - ${filterController.priceMaxValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // For Area Sqft
  void showAreaSqftMinSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateAreaSqftListMin(
        int.parse(filterController.filterToolsDataModel.maxSize.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Area',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setSqftMinValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Min Area===> ${filterController.sqftMinTitle} - ${filterController.sqftMinValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showAreaSqftMaxSelectionDialog(
      BuildContext context, GetFilterTools filterController) {
    List<PriceModel> priceList = Formatter.generateAreaSqftListMax(
        int.parse(filterController.filterToolsDataModel.maxSize.toString()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: InkWell(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 110,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Area',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                      const Gap(5), // Add some spacing between elements
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: priceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                filterController.setSqftMaxValue(
                                    priceList[index].title.toString(),
                                    priceList[index].actualPrice?.toDouble() ??
                                        0.0);
                                print(
                                    "Max area===> ${filterController.sqftMaxTitle} - ${filterController.sqftMaxValue}");
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4), // Add spacing between items
                                child: Text(
                                  priceList[index].title.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<GetFilterTools>(context);
    final homeViewController = Provider.of<HomeVIewController>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        filterController.clearAllFilters();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeMain,
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   elevation: 1,
        //   centerTitle: true,
        //   title: Text(
        //     "Property Filter",
        //     style: Theme.of(context)
        //         .textTheme
        //         .labelLarge!
        //         .copyWith(color: textColor),
        //   ),
        //   leading: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(width: 1, color: borderColor)),
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: InkWell(
        //           onTap: () {
        //             filterController.clearAllFilters();
        //             Navigator.pushNamedAndRemoveUntil(
        //               context,
        //               AppRoutes.homeMain,
        //               (route) => false,
        //             );
        //           },
        //           child: Icon(
        //             Icons.arrow_back,
        //             color: iconColor,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: defaultGradient3,
          ),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 30.0, 10.0, 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          filterController.clearAllFilters();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeMain,
                            (route) => false,
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Property Filter",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: textColor),
                    ),
                    const Spacer(),
                  ],
                ),
              )),
              Expanded(
                  flex: 8,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  filterController.setIsVerified("BUY");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient:
                                        filterController.isVerified == "BUY"
                                            ? defaultGradient3
                                            : null,
                                    border: Border.all(
                                        color:
                                            filterController.isVerified == "BUY"
                                                ? Colors.transparent
                                                : borderColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'BUY',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 12,
                                              color:
                                                  filterController.isVerified ==
                                                          "BUY"
                                                      ? Colors.white
                                                      : textColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              // Rent Button
                              InkWell(
                                onTap: () {
                                  filterController.setIsVerified("RENT");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: filterController.isVerified ==
                                                  "RENT"
                                              ? Colors.transparent
                                              : borderColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                      gradient:
                                          filterController.isVerified == "RENT"
                                              ? defaultGradient3
                                              : null),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'RENT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 12,
                                              color:
                                                  filterController.isVerified ==
                                                          "RENT"
                                                      ? Colors.white
                                                      : textColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10.0),
                          searchBar(homeViewController, _searchController,
                              voiceText, _speechToText),
                          const Gap(15),
                          homeViewController.isLoadingLocation == true
                              ? const Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      )),
                                )
                              : InkWell(
                                  onTap: () {
                                    homeViewController.checkPermission().then(
                                      (value) {
                                        String fullAddress = value.toString();
                                        String extractedAddress = fullAddress
                                            .split("Address: ")[1]
                                            .trim()
                                            .split(",")
                                            .join("");
                                        _searchController.text =
                                            extractedAddress.toString();
                                        filterController.setSearchKeyword(
                                            _searchController.text);
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/loc.svg",
                                        height: 20,
                                        width: 20,
                                        color: iconColor,
                                      ),
                                      Text(
                                        "Use My Current Location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: iconColor,
                                      )
                                    ],
                                  ),
                                ),
                          const Gap(15),
                          const SubPageTitlesHeading2(
                              title: "Properties Near You"),
                          const Gap(10),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.fromLTRB(
                                          0.0, 5.0, 5.0, 5.0)
                                      : const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (filterController.disKm == index + 1) {
                                        filterController.setDistKm(0.0);
                                      } else {
                                        filterController.setDistKm(index + 1);
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 33,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gradient: filterController.disKm ==
                                                  index + 1
                                              ? defaultGradient3
                                              : null,
                                          border: filterController.disKm ==
                                                  index + 1
                                              ? Border.all(
                                                  width: 1,
                                                  color: Colors.transparent)
                                              : Border.all(
                                                  width: 1,
                                                  color: borderColor)),
                                      child: Text(
                                        "${index + 1}KM",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: filterController.disKm ==
                                                        index + 1
                                                    ? Colors.white
                                                    : textColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(
                              title: "Price Range IN ${AppText.rupeeSymbol}"),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (filterController.isVerified == "BUY") {
                                      showPriceBuyMinSelectionDialog(
                                          context, filterController);
                                    } else {
                                      showPriceRentMinSelectionDialog(
                                          context, filterController);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: borderColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            filterController.priceMinTitle
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(fontSize: 10),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "to",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic),
                              ),
                              const Gap(10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (filterController.isVerified == "BUY") {
                                      showPriceBuyMaxSelectionDialog(
                                          context, filterController);
                                    } else {
                                      showPriceRentMaxSelectionDialog(
                                          context, filterController);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: borderColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            filterController.priceMaxTitle
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(fontSize: 10),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "BHK Type"),
                          const Gap(10),
                          Wrap(
                            runSpacing: 5.0, // vertical space between rows
                            spacing: 5.0,
                            children: List.generate(
                              filterController
                                      .filterToolsDataModel.bhkType?.length ??
                                  0,
                              (index) => InkWell(
                                onTap: () {
                                  filterController.toggleSelectedBHKType(
                                      filterController.filterToolsDataModel
                                              .bhkType?[index].flattype ??
                                          "0");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.045,
                                  width: size.height * 0.073,
                                  decoration: filterController.selectedBHKType
                                          .contains(
                                              '"${filterController.filterToolsDataModel.bhkType?[index].flattype.toString()}"')
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: defaultGradient3,
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: borderColor),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      filterController.filterToolsDataModel
                                              .bhkType?[index].flattype ??
                                          "0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              color: filterController
                                                      .selectedBHKType
                                                      .contains(
                                                          '"${filterController.filterToolsDataModel.bhkType?[index].flattype.toString()}"')
                                                  ? Colors.white
                                                  : textColor,
                                              fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "Area sqft"),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showAreaSqftMinSelectionDialog(
                                        context, filterController);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: borderColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            filterController.sqftMinTitle ??
                                                "No Min",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(fontSize: 10),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "to",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic),
                              ),
                              const Gap(10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showAreaSqftMaxSelectionDialog(
                                        context, filterController);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: borderColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            filterController.sqftMaxTitle ??
                                                "No Max",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(fontSize: 10),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "Location"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showLocationBottomSheet(
                                  context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedAreaName.isNotEmpty
                                    ? Wrap(
                                        children: List.generate(
                                          filterController
                                              .selectedAreaName.length,
                                          (index) {
                                            final areaName = filterController
                                                .selectedAreaName[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color of the container
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Set border radius to make it rounded
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Ensure the row takes up only the space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      // Add horizontal padding for the label
                                                      child: Text(
                                                        areaName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Set text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected area id====>${filterController.selectedAreas[index]}");
                                                        print(
                                                            "selected area name====>${filterController.selectedAreaName[index]}");
                                                        filterController
                                                            .toggleSelectedArea(
                                                          filterController
                                                                  .selectedAreas[
                                                                      index]
                                                                  .toString() ??
                                                              "",
                                                          filterController
                                                              .selectedAreaName[
                                                                  index]
                                                              .toString(),
                                                        );
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        // Padding around the delete icon
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Select Location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "Property Type"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showPropertyTypeBottomSheet(
                                  context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedPropertyTypeName.isNotEmpty
                                    ? Wrap(
                                        spacing: 8.0, // Space between chips
                                        runSpacing:
                                            4.0, // Space between rows if wrapped
                                        children: List.generate(
                                          filterController
                                              .selectedPropertyTypeName.length,
                                          (index) {
                                            final pName = filterController
                                                    .selectedPropertyTypeName[
                                                index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Only take up space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        pName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected type id====>${filterController.selectedPropertyType[index]}");
                                                        print(
                                                            "selected type name====>${filterController.selectedPropertyTypeName[index]}");
                                                        filterController
                                                            .toggleSelectedPropertyType(
                                                                filterController
                                                                    .selectedPropertyType[
                                                                        index]
                                                                    .toString(),
                                                                filterController
                                                                    .selectedPropertyTypeName[
                                                                        index]
                                                                    .toString());
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Select Property Type",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(
                              title: "Property Sub Type"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showPropertySubTypeBottomSheet(
                                  context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedPropertySubTypeName.isNotEmpty
                                    ? Wrap(
                                        spacing: 8.0, // Space between chips
                                        runSpacing:
                                            4.0, // Space between rows if wrapped
                                        children: List.generate(
                                          filterController
                                              .selectedSubPropertyType.length,
                                          (index) {
                                            final pName = filterController
                                                    .selectedPropertySubTypeName[
                                                index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Only take up space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        pName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected type id====>${filterController.selectedSubPropertyType[index]}");
                                                        print(
                                                            "selected type name====>${filterController.selectedPropertySubTypeName[index]}");
                                                        filterController
                                                            .toggleSelectedSubPropertyType(
                                                                filterController
                                                                    .selectedSubPropertyType[
                                                                        index]
                                                                    .toString(),
                                                                filterController
                                                                    .selectedPropertySubTypeName[
                                                                        index]
                                                                    .toString());
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Select Property Sub Type",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "By Builder"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showBuilderBottomSheet(context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedByBuilderName.isNotEmpty
                                    ? Wrap(
                                        spacing: 8.0, // Space between chips
                                        runSpacing:
                                            4.0, // Space between rows if wrapped
                                        children: List.generate(
                                          filterController
                                              .selectedByBuilder.length,
                                          (index) {
                                            final pName = filterController
                                                .selectedByBuilderName[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Only take up space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        pName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected builder id====>${filterController.selectedByBuilder[index]}");
                                                        print(
                                                            "selected builder name====>${filterController.selectedByBuilderName[index]}");
                                                        filterController
                                                            .toggleSelectedByBuilder(
                                                                filterController
                                                                    .selectedByBuilder[
                                                                        index]
                                                                    .toString(),
                                                                filterController
                                                                    .selectedByBuilderName[
                                                                        index]
                                                                    .toString());
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Select Builder",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(title: "Property Status"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showPropertyStatusBottomSheet(
                                  context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedConstructionType.isNotEmpty
                                    ? Wrap(
                                        spacing: 8.0, // Space between chips
                                        runSpacing:
                                            4.0, // Space between rows if wrapped
                                        children: List.generate(
                                          filterController
                                              .selectedConstructionType.length,
                                          (index) {
                                            final pName = filterController
                                                    .selectedConstructionType[
                                                index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Only take up space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        pName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected status name====>${filterController.selectedConstructionType[index]}");
                                                        filterController
                                                            .toggleSelectedConstructionType(
                                                                filterController
                                                                    .selectedConstructionType[
                                                                        index]
                                                                    .toString());
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Property Status",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const SubPageTitlesHeading2(
                              title: "Property Interior"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              showPropertyInteriorBottomSheet(
                                  context, filterController);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: borderColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: filterController
                                        .selectedPropertyInterior.isNotEmpty
                                    ? Wrap(
                                        spacing: 8.0, // Space between chips
                                        runSpacing:
                                            4.0, // Space between rows if wrapped
                                        children: List.generate(
                                          filterController
                                              .selectedPropertyInterior.length,
                                          (index) {
                                            final pName = filterController
                                                    .selectedPropertyInterior[
                                                index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets
                                                    .zero, // Set padding to zero
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  // Set background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Only take up space needed
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        pName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black), // Text style
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            "selected interior name====>${filterController.selectedPropertyInterior[index]}");
                                                        filterController
                                                            .toggleSelectedPropertyInterior(
                                                                filterController
                                                                    .selectedPropertyInterior[
                                                                        index]
                                                                    .toString());
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 16, // Icon size
                                                          color: Colors
                                                              .black54, // Icon color
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Text(
                                        "Property Interior",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.mainFilter,
                    arguments: PassFilterModel(
                        id: 6, logLate: "", title: "Main Filter"),
                  );
                },
                child: Container(
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: defaultGradient3,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "See all Properties",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: buttonTextColor),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget customPopupItemBuilder(BuildContext context, item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item,
          style: Theme.of(context).textTheme.labelSmall, // Small font size
        ),
      ),
    );
  }
}

void _showVoiceSpeedDialog(BuildContext context, SpeechToText speechToText) {
  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Start a timer that will close the dialog after 3 seconds
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pop(); // Automatically close the dialog
      });

      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          width: 150, // Adjust width for a smaller container
          height: 170, // Adjust height for a smaller container
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the contents vertically
            children: [
              Text(
                "Start Speech",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge, // Adjust text size as needed
                textAlign: TextAlign.center,
              ),
              const Gap(10), // Space between text and icon
              Center(
                child: AvatarGlow(
                  animate: true,
                  glowColor: textColor3,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: textColor3.withOpacity(0.1),
                    child: Icon(
                      Icons.mic,
                      color: accentColor,
                      size: 26, // Adjust icon size
                    ),
                  ),
                ),
              ),
              const Gap(10), // Space between text and icon
            ],
          ),
        ),
      );
    },
  ).whenComplete(() {
    speechToText.stop(); // Stop speech-to-text when dialog is closed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        (context as Element).markNeedsBuild(); // Ensures UI rebuild
      }
    });
  });
}

Container searchBar(
    HomeVIewController homeViewController,
    TextEditingController searchController,
    dynamic voiceText,
    SpeechToText speechToText) {
  final LayerLink layerLink = LayerLink();
  return Container(
    alignment: Alignment.center,
    height: 40,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
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
                  link: layerLink,
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return homeViewController.suggestionTextModel.data!.where(
                          (word) => word
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (option) {
                      print("The $option was selected");
                      searchController.text = option.toString();
                      context.read<GetFilterTools>().setSearchKeyword(
                          searchController.text.toString() ?? "");
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
                        onChanged: (value) {
                          if (searchController.text.isEmpty) {
                            searchController.clear();
                          } else {
                            searchController.text = value;
                            context.read<GetFilterTools>().setSearchKeyword(
                                searchController.text.toString() ?? "");
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Here',
                          contentPadding: const EdgeInsets.only(bottom: 10.0),
                          hintStyle: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    },
                    optionsViewOpenDirection: OptionsViewOpenDirection.down,
                    optionsViewBuilder: (context, onSelected, options) {
                      return CompositedTransformFollower(
                        link: layerLink,
                        showWhenUnlinked: false,
                        offset: const Offset(-26, 35),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.shade300,
                              //     blurRadius: 4,
                              //     spreadRadius: 5,
                              //     offset: const Offset(0, 2),
                              //   )
                              // ],
                            ),
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    overflow: TextOverflow.visible,
                                    options.elementAt(index),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
            const Gap(10.0),
            InkWell(
                onTap: () {
                  _showVoiceSpeedDialog(context, speechToText);
                  value.setVoiceEnable(true);
                  if (value.isAvailable) {
                    speechToText.listen(
                      onResult: (result) {
                        if (kDebugMode) {
                          print("Voice recognized: ${result.recognizedWords}");
                        }
                        context
                            .read<GetFilterTools>()
                            .updateVoiceText(result.recognizedWords);
                        searchController.text =
                            context.read<GetFilterTools>().voiceText;
                        context
                            .read<GetFilterTools>()
                            .setSearchKeyword(searchController.text);
                      },
                    );
                  }
                },
                child: Icon(
                  Icons.mic_none,
                  color: iconColor,
                )),
            const Gap(10.0),
          ],
        );
      },
    ),
  );
}

// Locations
void showLocationBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              filterController.filterLocationSearch(value);
                            },
                            style: Theme.of(context).textTheme.labelSmall,
                            decoration: InputDecoration(
                              hintText: "Search Town",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: hintColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController.locations.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedArea(
                                filterController.locations[index].id
                                        .toString() ??
                                    "",
                                filterController.locations[index].name
                                    .toString(),
                              );
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedArea(
                                        filterController.locations[index].id
                                                .toString() ??
                                            "",
                                      ) ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedArea(
                                      filterController.locations[index].id
                                              .toString() ??
                                          "",
                                      filterController.locations[index].name
                                          .toString(),
                                    );
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.locations[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        color: textColor3,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  ).whenComplete(
    () => filterController.resetSearch(),
  );
}

//Property Type
void showPropertyTypeBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController
                                .filterToolsDataModel.type?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedPropertyType(
                                filterController
                                        .filterToolsDataModel.type?[index].id
                                        .toString() ??
                                    "",
                                filterController
                                        .filterToolsDataModel.type?[index].name
                                        .toString() ??
                                    "",
                              );
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedPType(
                                        filterController.filterToolsDataModel
                                                .type?[index].id
                                                .toString() ??
                                            "",
                                      ) ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedPropertyType(
                                      filterController.filterToolsDataModel
                                              .type?[index].id
                                              .toString() ??
                                          "",
                                      filterController.filterToolsDataModel
                                              .type?[index].name
                                              .toString() ??
                                          "",
                                    );
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .type?[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        color: textColor3,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

//Property Sub Type
void showPropertySubTypeBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              filterController.filterPropertyTypeSearch(value);
                            },
                            style: Theme.of(context).textTheme.labelSmall,
                            decoration: InputDecoration(
                              hintText: "Search Property Sub Type",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: hintColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController.propertyTypes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedSubPropertyType(
                                filterController.propertyTypes[index].id
                                        .toString() ??
                                    "",
                                filterController.propertyTypes[index].name
                                    .toString(),
                              );
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController
                                          .isSelectedSubPropertyType(
                                        filterController.propertyTypes[index].id
                                                .toString() ??
                                            "",
                                      ) ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController
                                        .toggleSelectedSubPropertyType(
                                      filterController.propertyTypes[index].id
                                              .toString() ??
                                          "",
                                      filterController.propertyTypes[index].name
                                          .toString(),
                                    );
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.propertyTypes[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        color: textColor3,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  ).whenComplete(
    () => filterController.resetSearch(),
  );
}

//Property Builder
void showBuilderBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController
                                .filterToolsDataModel.builders?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedByBuilder(
                                filterController.filterToolsDataModel
                                        .builders?[index].id
                                        .toString() ??
                                    "",
                                filterController.filterToolsDataModel
                                        .builders?[index].name
                                        .toString() ??
                                    "",
                              );
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedByBuilder(
                                        filterController.filterToolsDataModel
                                                .builders?[index].id
                                                .toString() ??
                                            "",
                                      ) ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedByBuilder(
                                      filterController.filterToolsDataModel
                                              .builders?[index].id
                                              .toString() ??
                                          "",
                                      filterController.filterToolsDataModel
                                              .builders?[index].name
                                              .toString() ??
                                          "",
                                    );
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .builders?[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                        color: textColor3,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

//Property Status
void showPropertyStatusBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController
                                .filterToolsDataModel.construction?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return filterController
                                      .filterToolsDataModel
                                      .construction?[index]
                                      .constructionstatus ==
                                  null
                              ? const Offstage()
                              : InkWell(
                                  onTap: () {
                                    filterController
                                        .toggleSelectedConstructionType(
                                      filterController
                                              .filterToolsDataModel
                                              .construction?[index]
                                              .constructionstatus
                                              .toString() ??
                                          "",
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: filterController
                                                .isSelectedConstructionType(
                                              filterController
                                                      .filterToolsDataModel
                                                      .construction?[index]
                                                      .constructionstatus
                                                      .toString() ??
                                                  "",
                                            ) ??
                                            false,
                                        onChanged: (bool? value) {
                                          filterController
                                              .toggleSelectedConstructionType(
                                            filterController
                                                    .filterToolsDataModel
                                                    .construction?[index]
                                                    .constructionstatus
                                                    .toString() ??
                                                "",
                                          );
                                        },
                                        checkColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        filterController
                                                .filterToolsDataModel
                                                .construction?[index]
                                                .constructionstatus
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              fontSize: 12.0,
                                              color: textColor3,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

//Property Interior
void showPropertyInteriorBottomSheet(
    BuildContext context, GetFilterTools filterController) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white),
            child: Consumer<GetFilterTools>(
              builder: (context, filterController, child) {
                return Column(
                  children: [
                    const Gap(10),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filterController.filterToolsDataModel
                                .propertyInterior?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return filterController
                                      .filterToolsDataModel
                                      .propertyInterior?[index]
                                      .propertyinterior ==
                                  null
                              ? const Offstage()
                              : InkWell(
                                  onTap: () {
                                    filterController
                                        .toggleSelectedPropertyInterior(
                                      filterController
                                              .filterToolsDataModel
                                              .propertyInterior?[index]
                                              .propertyinterior
                                              .toString() ??
                                          "",
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: filterController
                                                .isSelectedPropertyInterior(
                                              filterController
                                                      .filterToolsDataModel
                                                      .propertyInterior?[index]
                                                      .propertyinterior
                                                      .toString() ??
                                                  "",
                                            ) ??
                                            false,
                                        onChanged: (bool? value) {
                                          filterController
                                              .toggleSelectedPropertyInterior(
                                            filterController
                                                    .filterToolsDataModel
                                                    .propertyInterior?[index]
                                                    .propertyinterior
                                                    .toString() ??
                                                "",
                                          );
                                        },
                                        checkColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        filterController
                                                .filterToolsDataModel
                                                .propertyInterior?[index]
                                                .propertyinterior
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              fontSize: 12.0,
                                              color: textColor3,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

// body: ListView(
// children: [
// const Gap(10.0),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12.0),
// border: Border.all(width: 1, color: borderColor)),
// child: Padding(
// padding: const EdgeInsets.all(3.0),
// child: Row(
// children: [
// Icon(
// CupertinoIcons.checkmark_shield_fill,
// size: 18,
// color: Colors.green.withOpacity(0.6),
// ),
// Text(
// "BUY",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// Radio(
// activeColor: Colors.red,
// value: 5,
// groupValue: filterController.isVerified,
// onChanged: (value) {
// _fetchFilterData();
// // filterController.setIsVerified(value!);
// },
// )
// ],
// ),
// ),
// ),
// const Gap(20.0),
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12.0),
// border: Border.all(width: 1, color: borderColor)),
// child: Padding(
// padding: const EdgeInsets.all(3.0),
// child: Row(
// children: [
// const Icon(
// Icons.verified,
// size: 18,
// color: Colors.orange,
// ),
// Text(
// "RENT",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// Radio(
// activeColor: Colors.red,
// value: 3,
// groupValue: filterController.isVerified,
// onChanged: (value) {
// _fetchFilterData();
// // filterController.setIsVerified(value);
// },
// )
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// const Gap(10.0),
// filterController.isVerified == 5
// ? Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "PRICE RANGE",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// SfRangeSlider(
// activeColor: Colors.red,
// min: 500000.0,
// max: 50000000.0,
// values: filterController.valuesPriceBuy,
// stepSize: 500000,
// showTicks: true,
// showLabels: true,
// enableTooltip: true,
// minorTicksPerInterval: 1,
// dividerShape: const SfDividerShape(),
// showDividers: true,
// tooltipTextFormatterCallback:
// (actualValue, formattedText) {
// return Formatter.formatNumber(
// actualValue.toString());
// },
// labelFormatterCallback: (actualValue, formattedText) {
// return Formatter.formatNumber(
// actualValue.toString());
// },
// onChanged: (SfRangeValues values) {
// filterController.setRangeValueForBuy(values);
// },
// ),
// const Gap(10.0),
// filterController.priceRangeValueBuy1 < 1
// ? const Offstage()
//     : Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "PRICE  ${Formatter.formatNumber(filterController.priceRangeValueBuy1.toString())} - ${Formatter.formatNumber(filterController.priceRangeValueBuy2.toString())}",
// style:
// Theme.of(context).textTheme.labelSmall,
// )
// ],
// )
// ],
// ),
// )
//     : Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "PRICE RANGE",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// SfRangeSlider(
// activeColor: Colors.red,
// min: 5000.0,
// max: 500000.0,
// values: filterController.valuesPriceRent,
// stepSize: 50000,
// showTicks: true,
// showLabels: true,
// enableTooltip: true,
// minorTicksPerInterval: 1,
// tooltipTextFormatterCallback:
// (actualValue, formattedText) {
// return Formatter.formatNumber(
// actualValue.toString());
// },
// labelFormatterCallback: (actualValue, formattedText) {
// return Formatter.formatNumber(
// actualValue.toString());
// },
// onChanged: (SfRangeValues values) {
// filterController.setRangeValueForRent(values);
// },
// ),
// const Gap(10.0),
// filterController.priceRangeValueRent1 < 1
// ? const Offstage()
//     : Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "PRICE  ${Formatter.formatNumber(filterController.priceRangeValueRent1.toString())} - ${Formatter.formatNumber(filterController.priceRangeValueRent2.toString())}",
// style:
// Theme.of(context).textTheme.labelSmall,
// )
// ],
// )
// ],
// ),
// ),
// const Gap(20),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "AREA SIZE (SQ.FT.)",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// SfRangeSlider(
// activeColor: Colors.red,
// min: 500.0,
// max: 30000.0,
// values: filterController.valuesAreaRange,
// stepSize: 1000,
// showTicks: true,
// showLabels: true,
// enableTooltip: true,
// minorTicksPerInterval: 1,
// labelFormatterCallback: (actualValue, formattedText) {
// if (actualValue == 30000.0) {
// return '$formattedText+';
// } else {
// return formattedText;
// }
// },
// onChanged: (SfRangeValues values) {
// filterController.setAreaValue(values);
// },
// ),
// const Gap(10.0),
// filterController.areaRangeValue1 < 1
// ? const Offstage()
//     : Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "AREA (SQ.FT.) ${filterController.areaRangeValue1.toInt()} - ${filterController.areaRangeValue2.toInt()}",
// style: Theme.of(context).textTheme.labelSmall,
// )
// ],
// )
// ],
// ),
// ),
// const Gap(20),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "AREA KM UPTO",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// SfRangeSlider(
// activeColor: Colors.red,
// min: 0.0,
// max: 5.0,
// values: filterController.valuesAreaRangeKm,
// stepSize: 1,
// showTicks: true,
// showLabels: true,
// enableTooltip: true,
// minorTicksPerInterval: 1,
// onChanged: (SfRangeValues values) {
// filterController.setAreaKmValue(values);
// },
// ),
// const Gap(10.0),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "AREA KM UPTO ${filterController.areaRangeKm1.toInt()} - ${filterController.areaRangeKm2.toInt()}",
// style: Theme.of(context).textTheme.labelSmall,
// )
// ],
// )
// ],
// ),
// ),
// // //Where,
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "LOCATIONS",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10.0, vertical: 10.0),
// child: Container(
// height: 40,
// alignment: Alignment.centerLeft,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.0),
// border: Border.all(width: 1, color: borderColor),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: TextFormField(
// onChanged: (value) {
// filterController.filterLocationSearch(value);
// },
// style: Theme.of(context).textTheme.labelSmall,
// decoration: InputDecoration(
// hintText: "Search Town",
// hintStyle: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(color: hintColor),
// border: InputBorder.none,
// ),
// ),
// ),
// ),
// ),
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController.locations.length ?? 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// filterController.toggleSelectedArea(
// filterController.locations[index].id.toString() ??
// "",
// filterController.locations[index].name.toString(),
// );
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController.isSelectedArea(
// filterController.locations[index].id
//     .toString() ??
// "",
// ) ??
// false,
// onChanged: (bool? value) {
// filterController.toggleSelectedArea(
// filterController.locations[index].id
//     .toString() ??
// "",
// filterController.locations[index].name
//     .toString(),
// );
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController.locations[index].name
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// if (filterController.selectedAreaName.isNotEmpty)
// Column(
// children: [
// const Gap(10.0),
// SizedBox(
// height: 40,
// child: ListView.builder(
// padding:
// const EdgeInsets.symmetric(horizontal: 5.0),
// itemCount: filterController.selectedAreaName.length,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// final locationName =
// filterController.selectedAreaName[index];
// final id = filterController.selectedAreas[index];
//
// return Padding(
// padding: const EdgeInsets.all(3.0),
// child: Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8.0),
// color: textColor3,
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8.0, vertical: 5.0),
// child: Row(
// children: [
// Text(
// "$locationName",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(color: buttonTextColor),
// ),
// const Gap(5.0),
// InkWell(
// onTap: () {
// filterController.toggleSelectedArea(
// id, locationName);
// },
// child: Icon(
// Icons.close,
// color: buttonTextColor,
// size: 16,
// ),
// ),
// ],
// ),
// ),
// ),
// );
// },
// ),
// ),
// const Gap(5.0),
// ],
// ),
// ],
// ),
// ),
//
// //Property Type,
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "PROPERTY TYPE",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController
//     .filterToolsDataModel.type?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// // filterController.toggleSelectedSubPropertyType(
// //     filterController
// //             .filterToolsDataModel.type?[index].id
// //             .toString() ??
// //         "");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController
//     .isSelectedSubPropertyType(
// filterController
//     .filterToolsDataModel
//     .type?[index]
//     .id
//     .toString() ??
// "") ??
// false,
// onChanged: (bool? value) {
// // filterController
// //     .toggleSelectedSubPropertyType(
// //         filterController
// //                 .filterToolsDataModel
// //                 .type?[index]
// //                 .id
// //                 .toString() ??
// //             "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController.filterToolsDataModel
//     .type?[index].name
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ]),
// ),
// //Property sub Types,
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "SUB TYPE",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10.0, vertical: 10.0),
// child: Container(
// height: 40,
// alignment: Alignment.centerLeft,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.0),
// border: Border.all(width: 1, color: borderColor)),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: TextFormField(
// onChanged: (value) {
// filterController.filterPropertyTypeSearch(value);
// },
// style: Theme.of(context).textTheme.labelSmall,
// decoration: InputDecoration(
// hintText: "Search Sub Property Type",
// hintStyle: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(color: hintColor),
// border: InputBorder.none,
// ),
// ),
// ),
// ),
// ),
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController
//     .filterToolsDataModel.propertyType?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// filterController.toggleSelectedPropertyType(
// filterController.filterToolsDataModel
//     .propertyType?[index].id
//     .toString() ??
// "",
// filterController.filterToolsDataModel
//     .propertyType?[index].name
//     .toString() ??
// "");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController.isSelectedPType(
// filterController.filterToolsDataModel
//     .propertyType?[index].id
//     .toString() ??
// "") ??
// false,
// onChanged: (bool? value) {
// filterController.toggleSelectedPropertyType(
// filterController.filterToolsDataModel
//     .propertyType?[index].id
//     .toString() ??
// "",
// filterController.filterToolsDataModel
//     .propertyType?[index].name
//     .toString() ??
// "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController.filterToolsDataModel
//     .propertyType?[index].name
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// Gap(filterController.selectedPropertyTypeName.length != 0
// ? 10.0
//     : 0.0),
// filterController.selectedPropertyTypeName.length != 0
// ? SizedBox(
// height: 40,
// child: ListView.builder(
// padding:
// const EdgeInsets.symmetric(horizontal: 5.0),
// itemCount: filterController
//     .selectedPropertyTypeName.length,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// final subPTypeName = filterController
//     .selectedPropertyTypeName[index];
// final id = filterController
//     .selectedPropertyType[index];
// return Padding(
// padding: const EdgeInsets.all(3.0),
// child: Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(8.0),
// color: textColor3),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8.0, vertical: 5.0),
// child: Row(
// children: [
// Text(
// "$subPTypeName",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// color: buttonTextColor),
// ),
// const Gap(5.0),
// InkWell(
// onTap: () {
// filterController
//     .toggleSelectedPropertyType(
// id, subPTypeName);
// },
// child: Icon(
// Icons.close,
// color: buttonTextColor,
// size: 16,
// ),
// ),
// ],
// ),
// )),
// );
// },
// ),
// )
//     : const Offstage(),
// Gap(filterController.selectedAreaName.length != 0
// ? 5.0
//     : 0.0),
// ]),
// ),
// //By Builder,
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "BY BUILDER",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController
//     .filterToolsDataModel.builders?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// // filterController.toggleSelectedByBuilder(
// //     filterController.filterToolsDataModel
// //             .builders?[index].id
// //             .toString() ??
// //         "");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController.isSelectedByBuilder(
// filterController.filterToolsDataModel
//     .builders?[index].id
//     .toString() ??
// "") ??
// false,
// onChanged: (bool? value) {
// // filterController.toggleSelectedByBuilder(
// //     filterController.filterToolsDataModel
// //             .builders?[index].id
// //             .toString() ??
// //         "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController.filterToolsDataModel
//     .builders?[index].name
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ]),
// ),
// //BHK type
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "BHK TYPE",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController
//     .filterToolsDataModel.bhkType?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// filterController.toggleSelectedBHKType(
// filterController.filterToolsDataModel
//     .bhkType?[index].flattype ??
// "0");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController.isSelectedBHKType(
// filterController.filterToolsDataModel
//     .bhkType?[index].flattype ??
// "0") ??
// false,
// onChanged: (bool? value) {
// filterController.toggleSelectedBHKType(
// filterController.filterToolsDataModel
//     .bhkType?[index].flattype ??
// "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController.filterToolsDataModel
//     .bhkType?[index].flattype
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ]),
// ),
//
// //CONSTRUCTION STATUS
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "PROPERTY STATUS",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController
//     .filterToolsDataModel.construction?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// filterController.toggleSelectedConstructionType(
// filterController
//     .filterToolsDataModel
//     .construction?[index]
//     .constructionstatus ??
// "");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController
//     .isSelectedConstructionType(
// filterController
//     .filterToolsDataModel
//     .construction?[index]
//     .constructionstatus ??
// "") ??
// false,
// onChanged: (bool? value) {
// filterController
//     .toggleSelectedConstructionType(
// filterController
//     .filterToolsDataModel
//     .construction?[index]
//     .constructionstatus ??
// "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController
//     .filterToolsDataModel
//     .construction?[index]
//     .constructionstatus
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ]),
// ),
//
// //CONSTRUCTION STATUS
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: ExpansionTile(
// title: Text(
// "PROPERTY INTERIOR",
// style: Theme.of(context).textTheme.labelSmall,
// ),
// children: [
// SizedBox(
// height: 200,
// child: ListView.builder(
// padding: const EdgeInsets.only(bottom: 20),
// itemCount: filterController.filterToolsDataModel
//     .propertyInterior?.length ??
// 0,
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// filterController.toggleSelectedPropertyInterior(
// filterController
//     .filterToolsDataModel
//     .propertyInterior?[index]
//     .propertyinterior ??
// "");
// },
// child: Row(
// children: [
// Checkbox(
// value: filterController
//     .isSelectedPropertyInterior(
// filterController
//     .filterToolsDataModel
//     .propertyInterior?[index]
//     .propertyinterior ??
// "") ??
// false,
// onChanged: (bool? value) {
// filterController
//     .toggleSelectedPropertyInterior(
// filterController
//     .filterToolsDataModel
//     .propertyInterior?[index]
//     .propertyinterior ??
// "");
// },
// checkColor: Colors.white,
// ),
// const SizedBox(width: 10),
// Text(
// filterController
//     .filterToolsDataModel
//     .propertyInterior?[index]
//     .propertyinterior
//     .toString() ??
// "",
// style: Theme.of(context)
//     .textTheme
//     .labelSmall!
//     .copyWith(
// fontSize: 12.0, color: textColor3),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ]),
// ),
// ],
// ),
