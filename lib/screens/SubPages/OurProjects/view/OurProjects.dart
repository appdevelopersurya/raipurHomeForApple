import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fmraipuromes/Skeletons/HomeSkeleton.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/OutProjectDataModels.dart';
import 'package:fmraipuromes/screens/SubPages/OurProjects/viewModel/OurProjectsViewsModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/ourPageFeaturedCard.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../app/routes/routes.dart';
import '../../../../constant/appText.dart';
import '../../../../data/modal/passFilterModel.dart';
import '../../../../helper/GetStorageHelper.dart';
import '../../../../repository/contactFeatures.dart';
import '../../../../utils/CustomButton.dart';
import '../../../../utils/FeaturedPropertyCard.dart';
import '../../../../utils/HomeTitlesHeading.dart';
import '../../../../utils/NormalAppBar.dart';
import '../../../Home/viewModal/homeViewController.dart';

class OurProjects extends StatefulWidget {
  final PassFilterModel allListArgsModal;

  const OurProjects({
    super.key,
    required this.allListArgsModal,
  });

  @override
  State<OurProjects> createState() => _OurProjectsState();
}

class _OurProjectsState extends State<OurProjects> {
  _firstLoad() {
    final ourProjectController =
        Provider.of<OurProjectsViewModel>(context, listen: false);
    if (mounted) {
      ourProjectController.getProjectDetails(widget.allListArgsModal.id ?? 0);
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  final List<Map<String, String>> imagesList = [
    {"id": "1", "imageUrl": "https://via.placeholder.com/150"},
    {"id": "2", "imageUrl": "https://via.placeholder.com/200"},
    {"id": "3", "imageUrl": "https://via.placeholder.com/250"},
    {"id": "4", "imageUrl": "https://via.placeholder.com/300"},
    {"id": "5", "imageUrl": "https://via.placeholder.com/350"},
  ];

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
  Widget build(BuildContext context) {
    final ourProjectController = Provider.of<OurProjectsViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NormalAppBar(
        title: widget.allListArgsModal.title ?? "Page Title",
      ),
      body: ourProjectController.isLodingDetailsPage == true
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const HomeSkeleton())
          : ListView(
              children: [
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: size.height * 0.3,
                                width: size.width,
                                imageUrl:
                                    "${AppUrl.baseUrl}${ourProjectController.ourProjectDetailsDataModels.data?.projectImage.toString() ?? ""}",
                                // "https://www.raipurhomes.com/public/project_images/1725609092RADHE-KRISHNA--2.jpg",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    "assets/png/rprNewLogo.png",
                                    height: size.height * 0.3,
                                    width: size.width,
                                  );
                                },
                              ),
                            ),
                            const Gap(10.0),
                            Text(
                              textAlign: TextAlign.left,
                              ourProjectController.ourProjectDetailsDataModels
                                      .data?.projectName
                                      .toString() ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: accentColor),
                            ),
                            const Gap(10.0),
                            HtmlWidget(
                              ourProjectController.ourProjectDetailsDataModels
                                      .data?.discription
                                      .toString() ??
                                  "",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: textColor3.withOpacity(0.7)),
                            ),
                            const Gap(10.0),
                            const Divider(),
                            Row(
                              children: [
                                Icon(Icons.home,
                                    size: 18,
                                    color: textColor3.withOpacity(0.7)),
                                Text(
                                  " ${ourProjectController.ourProjectDetailsDataModels.data?.totalPost?.length ?? ""} properties",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: textColor3.withOpacity(0.7)),
                                ),
                                // const Spacer(),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       color: textColor3.withOpacity(0.1),
                                //       borderRadius: BorderRadius.circular(5.0)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.fromLTRB(
                                //         5.0, 2.0, 5.0, 2.0),
                                //     child: Text(
                                //       "View",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .labelSmall!
                                //           .copyWith(color: textColor3),
                                //     ),
                                //   ),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<OurProjectsViewModel>(
                  builder: (context, value, child) {
                    return value.ourProjectDetailsDataModels.allproperty
                                ?.length ==
                            0
                        ? const Offstage()
                        : FadeInRight(
                            duration: const Duration(milliseconds: 800),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: value.ourProjectDetailsDataModels
                                      .allproperty?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return FeaturedPropertyCardForHome2(
                                  onTapShare: () {
                                    Share.share(
                                        "🏡 Property Title : \n${value.ourProjectDetailsDataModels.allproperty?[index].title.toString()}"
                                        "\n📍 Location : ${value.ourProjectDetailsDataModels.allproperty?[index].jioLocation.toString()}"
                                        "\n ₹ Price : ${NumberFormat.currency(
                                      locale: 'HI',
                                      symbol: AppText.rupeeSymbol,
                                    ).format(int.parse(value.ourProjectDetailsDataModels.allproperty?[index].pricing.toString() ?? ''))}"
                                        "\n📏 Size : ${value.ourProjectDetailsDataModels.allproperty?[index].size.toString()} SQFT"
                                        "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                        "\n\nCheck out through this link :"
                                        "\nhttps://www.raipurhomes.com/property-details/${value.ourProjectDetailsDataModels.allproperty?[index].titleSlug.toString()}-${value.ourProjectDetailsDataModels.allproperty?[index].serviceId.toString()}");
                                  },
                                  onTapCall: () async => await ContactFeatures()
                                      .launchCalling(
                                          context,
                                          value.ourProjectDetailsDataModels
                                                  .adminDetails?.adminNumber
                                                  .toString() ??
                                              ""),
                                  onTapWhatsapp: () async =>
                                      await ContactFeatures().launchWhatsapp(
                                          context,
                                          value
                                                  .ourProjectDetailsDataModels
                                                  .adminDetails
                                                  ?.adminWhatsappNumber
                                                  .toString() ??
                                              "",
                                          "Hii i am interested in this property"
                                          "\n\n🏡 Property Title : \n${value.ourProjectDetailsDataModels.allproperty?[index].title.toString()}"
                                          "\n📍 Location : ${value.ourProjectDetailsDataModels.allproperty?[index].jioLocation.toString()}"
                                          "\n ₹ Price : ${NumberFormat.currency(
                                            locale: 'HI',
                                            symbol: AppText.rupeeSymbol,
                                          ).format(int.parse(value.ourProjectDetailsDataModels.allproperty?[index].pricing.toString() ?? ''))}"
                                          "\n📏 Size : ${value.ourProjectDetailsDataModels.allproperty?[index].size.toString()} SQFT"
                                          "\n\nProperty Link Here:"
                                          "\nhttps://www.raipurhomes.com/property-details/${value.ourProjectDetailsDataModels.allproperty?[index].titleSlug.toString()}-${value.ourProjectDetailsDataModels.allproperty?[index].serviceId.toString()}"),
                                  onTapFavorite: () {
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      textAlign:
                                                          TextAlign.center,
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
                                                          Navigator.pop(
                                                              context),
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
                                      value.setIsFav(
                                          value.ourProjectDetailsDataModels
                                                  .allproperty?[index].serviceId
                                                  .toString() ??
                                              "",
                                          index);
                                    }
                                  },
                                  isLoading: value.ourProjectDetailsDataModels
                                      .allproperty?[index].loading,
                                  isFavorite: value
                                              .ourProjectDetailsDataModels
                                              .allproperty?[index]
                                              .getBookMarkedProperty !=
                                          null
                                      ? true
                                      : false,
                                  onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.propertyDetailView,
                                      arguments: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .serviceId
                                          .toString()),
                                  views: value.ourProjectDetailsDataModels
                                          .allproperty?[index].visitCount
                                          .toString() ??
                                      "",
                                  size: size,
                                  forSale: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .getapiCategories
                                          ?.categoriesName
                                          .toString() ??
                                      "",
                                  type: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .getapiPropertySubType
                                          ?.name
                                          .toString() ??
                                      "",
                                  price: value.ourProjectDetailsDataModels
                                          .allproperty?[index].pricing
                                          .toString() ??
                                      "",
                                  title: value.ourProjectDetailsDataModels
                                          .allproperty?[index].title
                                          .toString() ??
                                      "",
                                  address: value.ourProjectDetailsDataModels
                                          .allproperty?[index].address
                                          .toString() ??
                                      "",
                                  imageList: value.ourProjectDetailsDataModels
                                          .allproperty?[index]?.getapiimages ??
                                      [],
                                  featureImage: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .featureImage ??
                                      "",
                                  priceType: value.ourProjectDetailsDataModels
                                          .allproperty?[index].pricetype
                                          .toString() ??
                                      "",
                                  constructionSize: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .size
                                          .toString() ??
                                      "",
                                  propertyFace: parsePropertyFace(value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .propertyface
                                          .toString() ??
                                      ""),
                                  openSide: value.ourProjectDetailsDataModels
                                          .allproperty?[index].openside
                                          .toString() ??
                                      "",
                                  subType: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .getapiPropertyType
                                          ?.name
                                          .toString() ??
                                      "",
                                  floorType: value.ourProjectDetailsDataModels
                                          .allproperty?[index].floortype
                                          .toString() ??
                                      "",
                                  flatType: value.ourProjectDetailsDataModels
                                          .allproperty?[index].flattype
                                          .toString() ??
                                      "",
                                  propertyInterior: value
                                          .ourProjectDetailsDataModels
                                          .allproperty?[index]
                                          .propertyinterior
                                          .toString() ??
                                      "",
                                );
                              },
                            ),
                          );
                  },
                ),
                const Gap(10.0),
                ourProjectController.ourProjectDetailsDataModels.letestproperty
                            ?.length ==
                        0
                    ? const Offstage()
                    : FadeInLeft(
                        child: const HomeTitlesHeading(
                          title: "Recent Posts:",
                        ),
                      ),
                Consumer<OurProjectsViewModel>(
                  builder: (context, value, child) {
                    return value.ourProjectDetailsDataModels.letestproperty
                                ?.length ==
                            0
                        ? const Offstage()
                        : SizedBox(
                            height: size.height * 0.65,
                            child: FadeInRight(
                              duration: const Duration(milliseconds: 800),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: value.ourProjectDetailsDataModels
                                        .letestproperty?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return FeaturedPropertyCardSqaure(
                                    onTapShare: () {
                                      Share.share(
                                          "🏡 Property Title : \n${value.ourProjectDetailsDataModels.letestproperty?[index].title.toString()}"
                                          "\n📍 Location : ${value.ourProjectDetailsDataModels.letestproperty?[index].jioLocation.toString()}"
                                          "\n ₹ Price : ${NumberFormat.currency(
                                        locale: 'HI',
                                        symbol: AppText.rupeeSymbol,
                                      ).format(int.parse(value.ourProjectDetailsDataModels.letestproperty?[index].pricing.toString() ?? ''))}"
                                          "\n📏 Size : ${value.ourProjectDetailsDataModels.letestproperty?[index].size.toString()} SQFT"
                                          "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                          "\n\nCheck out through this link :"
                                          "\nhttps://www.raipurhomes.com/property-details/${value.ourProjectDetailsDataModels.letestproperty?[index].titleSlug.toString()}-${value.ourProjectDetailsDataModels.allproperty?[index].serviceId.toString()}");
                                    },
                                    onTapCall: () async =>
                                        await ContactFeatures().launchCalling(
                                            context,
                                            value.ourProjectDetailsDataModels
                                                    .adminDetails?.adminNumber
                                                    .toString() ??
                                                ""),
                                    onTapWhatsapp: () async =>
                                        await ContactFeatures().launchWhatsapp(
                                            context,
                                            value
                                                    .ourProjectDetailsDataModels
                                                    .adminDetails
                                                    ?.adminWhatsappNumber
                                                    .toString() ??
                                                "",
                                            "Hii i am interested in this property"
                                            "\n\n🏡 Property Title : \n${value.ourProjectDetailsDataModels.letestproperty?[index].title.toString()}"
                                            "\n📍 Location : ${value.ourProjectDetailsDataModels.letestproperty?[index].jioLocation.toString()}"
                                            "\n ₹ Price : ${NumberFormat.currency(
                                              locale: 'HI',
                                              symbol: AppText.rupeeSymbol,
                                            ).format(int.parse(value.ourProjectDetailsDataModels.letestproperty?[index].pricing.toString() ?? ''))}"
                                            "\n📏 Size : ${value.ourProjectDetailsDataModels.letestproperty?[index].size.toString()} SQFT"
                                            "\n\nProperty Link Here:"
                                            "\nhttps://www.raipurhomes.com/property-details/${value.ourProjectDetailsDataModels.letestproperty?[index].titleSlug.toString()}-${value.ourProjectDetailsDataModels.letestproperty?[index].serviceId.toString()}"),
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
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                constraints:
                                                    BoxConstraints.loose(
                                                        const Size.fromHeight(
                                                            400)),
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                        Icons
                                                                            .close,
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                                                (route) =>
                                                                    false,
                                                              ),
                                                          title: "Yes, Login"),
                                                    ),
                                                    const Gap(10),
                                                    FadeInUp(
                                                      child: TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
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
                                        value.setIsFavThroughRecentProperty(
                                            value
                                                    .ourProjectDetailsDataModels
                                                    .letestproperty?[index]
                                                    .serviceId
                                                    .toString() ??
                                                "",
                                            index);
                                      }
                                    },
                                    isLoading: value.ourProjectDetailsDataModels
                                        .letestproperty?[index].loading,
                                    isFavorite: value
                                                .ourProjectDetailsDataModels
                                                .letestproperty?[index]
                                                .getBookMarkedProperty !=
                                            null
                                        ? true
                                        : false,
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.propertyDetailView,
                                        arguments: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .serviceId
                                            .toString()),
                                    views: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].visitCount
                                            .toString() ??
                                        "",
                                    size: size,
                                    forSale: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .getapiCategories
                                            ?.categoriesName
                                            .toString() ??
                                        "",
                                    type: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .getapiPropertySubType
                                            ?.name
                                            .toString() ??
                                        "",
                                    price: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].pricing
                                            .toString() ??
                                        "",
                                    title: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].title
                                            .toString() ??
                                        "",
                                    address: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].address
                                            .toString() ??
                                        "",
                                    imageList: value
                                            .ourProjectDetailsDataModels
                                            .allproperty?[index]
                                            ?.getapiimages ??
                                        [],
                                    featureImage: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .featureImage ??
                                        "",
                                    priceType: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].pricetype
                                            .toString() ??
                                        "",
                                    constructionSize: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .size
                                            .toString() ??
                                        "",
                                    propertyFace: parsePropertyFace(value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .propertyface
                                            .toString() ??
                                        ""),
                                    openSide: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].openside
                                            .toString() ??
                                        "",
                                    subType: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .getapiPropertyType
                                            ?.name
                                            .toString() ??
                                        "",
                                    floorType: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].floortype
                                            .toString() ??
                                        "",
                                    flatType: value.ourProjectDetailsDataModels
                                            .letestproperty?[index].flattype
                                            .toString() ??
                                        "",
                                    propertyInterior: value
                                            .ourProjectDetailsDataModels
                                            .letestproperty?[index]
                                            .propertyinterior
                                            .toString() ??
                                        "",
                                  );
                                },
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
    );
  }
}
