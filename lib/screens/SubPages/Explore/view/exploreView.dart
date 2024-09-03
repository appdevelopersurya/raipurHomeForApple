import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/SubPages/Explore/viewModel/exploreViewModel.dart';
import 'package:fmraipuromes/utils/FeaturedPropertyCard.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/routes/routes.dart';
import '../../../../constant/appText.dart';
import '../../../../constant/color.dart';
import '../../../../helper/GetStorageHelper.dart';
import '../../../../utils/CustomButton.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.25100669802757, 81.63005519830504),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  List<gmaps.Marker> _markers = [];

  _fetchExploreProperty() async {
    final exploreViewController =
        Provider.of<ExploreViewModel>(context, listen: false);
    exploreViewController.initializeController(this);
    if (mounted) {
      await exploreViewController.getExploreData();
      final properties = exploreViewController.allPropertyModel.data;
      exploreViewController.controllerInitializer(_searchController);
      if (properties != null) {
        List<gmaps.Marker> markers = properties.map((property) {
          double latitude = double.parse(property.latitude);
          double longitude = double.parse(property.longitude);
          return gmaps.Marker(
            onTap: () {
              print("on tap markersss======> ${property.jioLocation} ");
              var body = {"jeo_location": property.jioLocation.toString()};
              exploreViewController.fetchDependencyTools(body);
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent +
                    MediaQuery.of(context).size.height * 0.6,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
              setState(() {});
            },
            icon: gmaps.AssetMapBitmap(
                height: 25, width: 25, "assets/png/rphlogo.jpg"),
            draggable: true,
            markerId: MarkerId(property.serviceId.toString()),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: property.jioLocation,
              snippet: property.titleSlug,
            ),
          );
        }).toList();
        setState(() {
          _markers = markers;
        });
      }
    }
  }

  @override
  void initState() {
    _fetchExploreProperty();
    super.initState();
  }

  Future _onRefresh() {
    return _fetchExploreProperty();
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final exploreViewController = Provider.of<ExploreViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        exploreViewController.toggleSize(false);
        exploreViewController.setIsPlaced(false);
        exploreViewController.sePlaceListClear();
        Navigator.pop(context);
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
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

            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedBuilder(
                    animation: exploreViewController.controllerAnimation1!,
                    builder: (BuildContext context, Widget? child) {
                      double textWidth = size.width *
                          0.5 *
                          (1 -
                              exploreViewController
                                  .controllerAnimation1!.value);
                      return SizedBox(
                        width: textWidth,
                        child: Text(
                          "Explore Property",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: textColor2),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedBuilder(
                      animation: exploreViewController.controllerAnimation1!,
                      builder: (context, child) {
                        double formWidth = size.width *
                            0.75 *
                            exploreViewController.controllerAnimation1!.value;
                        return Container(
                          height: 45,
                          width: formWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  var body = {
                                    "locarion_name":
                                        _searchController.text.toString()
                                  };
                                  exploreViewController
                                      .fetchDependencyTools(body);
                                  setState(() {});
                                }
                              },
                              controller: _searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  exploreViewController.setIsPlaced(false);
                                  _searchController.clear();
                                  exploreViewController.getExploreData();
                                } else {
                                  exploreViewController
                                      .onChanged(_searchController);
                                  exploreViewController.setIsPlaced(true);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Search Property",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: hintColor),
                                border: InputBorder.none,
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                              readOnly: !exploreViewController.isExpandedSearch,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            leading: InkWell(
              onTap: () {
                exploreViewController.toggleSize(false);
                exploreViewController.sePlaceListClear();
                exploreViewController.setIsPlaced(false);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: textColor2,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  if (exploreViewController.isExpandedSearch == false) {
                    exploreViewController.toggleSize(true);
                  } else {
                    _fetchExploreProperty();
                    exploreViewController.toggleSize(false);
                  }
                  _searchController.clear();
                  exploreViewController.sePlaceListClear();
                },
                child: exploreViewController.isExpandedSearch
                    ? Icon(
                        Icons.close,
                        color: textColor2,
                      )
                    : Icon(
                        Icons.search,
                        color: textColor2,
                      ),
              ),
              const Gap(10.0),
            ],
          ),
          body: exploreViewController.isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const ListViewBuilderSkeleton())
              : ListView(
                  controller: _scrollController,
                  children: [
                    exploreViewController.isPlaceList == false
                        ? const Offstage()
                        : SizedBox(
                            height: 200,
                            child: ListView.builder(
                              itemCount:
                                  exploreViewController.placeList.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      _searchController.text =
                                          exploreViewController.placeList[index]
                                              ["description"];
                                      exploreViewController.setIsPlaced(false);
                                      exploreViewController.sePlaceListClear();
                                    },
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(
                                        exploreViewController.placeList[index]
                                            ["description"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInDown(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: SizedBox(
                            height: size.height * 0.6,
                            width: size.width,
                            child: Stack(
                              children: [
                                if (_isLoading) // Conditionally show loading indicator
                                  const Center(
                                    child:
                                        CircularProgressIndicator(), // Replace with your custom loading widget if needed
                                  ),
                                // Actual Google Map widget
                                GoogleMap(
                                  zoomControlsEnabled: true,
                                  zoomGesturesEnabled: true,
                                  markers: Set<gmaps.Marker>.of(_markers),
                                  scrollGesturesEnabled: true,
                                  mapType: MapType.satellite,
                                  initialCameraPosition: _kGooglePlex,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController.complete(controller);
                                    setState(() {
                                      _isLoading =
                                          false; // Update state when map is created
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10.0),
                    exploreViewController.allPropertyModel.data?.length == 0
                        ? Center(child: Lottie.asset("assets/gif/noData.json"))
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: exploreViewController
                                    .allPropertyModel.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return FadeInUp(
                                child: FeaturedPropertyCardForHome(
                                  onTapShare: () {
                                    Share.share(
                                        "🏡 Property Title : \n${exploreViewController.allPropertyModel.data?[index].title.toString()}"
                                        "\n📍 Location : ${exploreViewController.allPropertyModel.data?[index].jioLocation.toString()}"
                                        "\n ₹ Price : ${NumberFormat.currency(
                                      locale: 'HI',
                                      symbol: AppText.rupeeSymbol,
                                    ).format(int.parse(exploreViewController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                        "\n📏 Size : ${exploreViewController.allPropertyModel.data?[index].size.toString()} SQFT"
                                        "\n\nDiscover this fantastic property! Located in a prime area, it offers excellent value with plenty of space to suit your needs. Click the link to learn more and share with your friends!"
                                        "\n\nCheck out through this link :"
                                        "\nhttps://www.raipurhomes.com/property-details/${exploreViewController.allPropertyModel.data?[index].titleSlug.toString()}-${exploreViewController.allPropertyModel.data?[index].serviceId.toString()}");
                                  },
                                  onTapCall: () async => await ContactFeatures()
                                      .launchCalling(
                                          context,
                                          exploreViewController.allPropertyModel
                                                  .adminDetails?.adminNumber
                                                  .toString() ??
                                              ""),
                                  onTapWhatsapp: () async =>
                                      await ContactFeatures().launchWhatsapp(
                                          context,
                                          exploreViewController
                                                  .allPropertyModel
                                                  .adminDetails
                                                  ?.adminWhatsappNumber
                                                  .toString() ??
                                              "",
                                          "Hii i am interested in this property"
                                          "\n\n🏡 Property Title : \n${exploreViewController.allPropertyModel.data?[index].title.toString()}"
                                          "\n📍 Location : ${exploreViewController.allPropertyModel.data?[index].jioLocation.toString()}"
                                          "\n ₹ Price : ${NumberFormat.currency(
                                            locale: 'HI',
                                            symbol: AppText.rupeeSymbol,
                                          ).format(int.parse(exploreViewController.allPropertyModel.data?[index].pricing.toString() ?? ''))}"
                                          "\n📏 Size : ${exploreViewController.allPropertyModel.data?[index].size.toString()} SQFT"
                                          "\n\nProperty Link Here:"
                                          "\nhttps://www.raipurhomes.com/property-details/${exploreViewController.allPropertyModel.data?[index].titleSlug.toString()}-${exploreViewController.allPropertyModel.data?[index].serviceId.toString()}"),
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
                                      exploreViewController.setIsFav(
                                          exploreViewController.allPropertyModel
                                                  .data?[index].serviceId
                                                  .toString() ??
                                              "",
                                          index);
                                    }
                                  },
                                  isLoading: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .loading ??
                                      false,
                                  isFavorite: exploreViewController
                                              .allPropertyModel
                                              .data?[index]
                                              .getBookMarkedProperty !=
                                          null
                                      ? true
                                      : false,
                                  onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.propertyDetailView,
                                      arguments: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .serviceId
                                          .toString()),
                                  views: exploreViewController.allPropertyModel
                                          .data?[index].visitCount
                                          .toString() ??
                                      "",
                                  size: size,
                                  forSale: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .getapiCategories
                                          ?.categoriesName
                                          .toString() ??
                                      "",
                                  type: exploreViewController.allPropertyModel
                                          .data?[index].getapiPType?.name
                                          .toString() ??
                                      "",
                                  price: exploreViewController
                                          .allPropertyModel.data?[index].pricing
                                          .toString() ??
                                      "",
                                  title: exploreViewController
                                          .allPropertyModel.data?[index].title
                                          .toString() ??
                                      "",
                                  address: exploreViewController
                                          .allPropertyModel.data?[index].address
                                          .toString() ??
                                      "",
                                  imageList: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .getapiimages ??
                                      [],
                                  featureImage: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .featureImage ??
                                      "",
                                  priceType: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .pricetype
                                          .toString() ??
                                      "",
                                  constructionSize: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .constructionSize
                                          .toString() ??
                                      "",
                                  propertyFace: parsePropertyFace(
                                      exploreViewController.allPropertyModel
                                              .data?[index].propertyface
                                              .toString() ??
                                          ""),
                                  openSide: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .openside
                                          .toString() ??
                                      "",
                                  subType: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .getapiPropertyType
                                          ?.name
                                          .toString() ??
                                      "",
                                  floorType: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .floortype
                                          .toString() ??
                                      "",
                                  flatType: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .flattype
                                          .toString() ??
                                      "",
                                  propertyInterior: exploreViewController
                                          .allPropertyModel
                                          .data?[index]
                                          .propertyinterior
                                          .toString() ??
                                      "",
                                ),
                              );
                            },
                          )
                  ],
                ),
        ),
      ),
    );
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
}
