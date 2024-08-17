import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/DataNew.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/PorpertyDetailsDataModel.dart';
import 'package:fmraipuromes/data/modal/SuggestionTextModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/screens/Home/viewModal/homeViewController.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class TestingDropDown extends StatefulWidget {
  const TestingDropDown({super.key});

  @override
  State<TestingDropDown> createState() => _TestingDropDownState();
}

class _TestingDropDownState extends State<TestingDropDown> {
  final ScrollController _scrollController = ScrollController();

  int _pageNo = 1;
  bool _isLoadingMore = false; // Track loading state
  bool _isLoadingMore2 = false; // Track loading state

  AllPropertyModel _allPropertyModel = AllPropertyModel();

  AllPropertyModel get allPropertyModel => _allPropertyModel;

  List<DataNew> _newList = [];

  Future<AllPropertyModel> getAllPropertyList(
      String category, int pageNo) async {
    try {
      final apiServices = NetworkApiServices();
      final response = await apiServices.getGetApiResponse(
        false,
        "${AppUrl.baseUrl}${AppUrl.authEndPoints.getAllPropertyList1}?category=$category&user_id=${box.read("cust_id_raipurHomes").toString()}&page=$pageNo",
      );

      if (kDebugMode) {
        print("All property response: $response");
      }

      // Parse the response into your model
      final allPropertyModel = AllPropertyModel.fromJson(response);

      // Ensure the data is not null and process it correctly
      if (allPropertyModel.data != null) {
        for (var element in allPropertyModel.data!) {
          _newList.add(DataNew(
            serviceId: element.serviceId,
            title: element.title,
            frontdepth: element.frontdepth,
            cyear: element.cyear,
            floortype: element.floortype,
            balconytype: element.balconytype,
            connectivity: element.connectivity,
            propertyownername: element.propertyownername,
            othercondition: element.othercondition,
            residenttype: element.residenttype,
            titleSlug: element.titleSlug,
            businessType: element.businessType,
            businessName: element.businessName,
            reviewPercent: element.reviewPercent,
            reviewCount: element.reviewCount,
            visitCount: element.visitCount,
            shortDesc: element.shortDesc,
            colony: element.colony,
            town: element.town,
            kmUpto: element.kmUpto,
            jioLocation: element.jioLocation,
            latitude: element.latitude,
            longitude: element.longitude,
            propertyface: element.propertyface,
            roadsize: element.roadsize,
            roadtype: element.roadtype,
            openside: element.openside,
            name: element.name,
            flattype: element.flattype,
            bathroom: element.bathroom,
            room: element.room,
            constructionstatus: element.constructionstatus,
            postedby: element.postedby,
            propertyinterior: element.propertyinterior,
            ameneties: element.ameneties,
            videoLink: element.videoLink,
            txtPass: element.txtPass,
            number: element.number,
            featureImage: element.featureImage,
            memebershipStarted: element.memebershipStarted,
            address: element.address,
            state: element.state,
            city: element.city,
            type: element.type,
            propertyType: element.propertyType,
            builderId: element.builderId,
            size: element.size,
            constructionSize: element.constructionSize,
            kycBankIfscCode: element.kycBankIfscCode,
            images1: element.images1,
            feature: element.feature,
            images3: element.images3,
            images4: element.images4,
            images5: element.images5,
            selectedCategories: element.selectedCategories,
            selectedNewCat: element.selectedNewCat,
            selectedCertificate: element.selectedCertificate,
            selectedSpecialist: element.selectedSpecialist,
            experience: element.experience,
            storeLocation: element.storeLocation,
            gifPath: element.gifPath,
            videoPath: element.videoPath,
            officeTimings: element.officeTimings,
            pricing: element.pricing,
            pricetype: element.pricetype,
            offerPrice: element.offerPrice,
            discount: element.discount,
            coupleDiscount: element.coupleDiscount,
            familyDiscount: element.familyDiscount,
            isReview: element.isReview,
            kycActivationStatus: element.kycActivationStatus,
            status: element.status,
            featureStatus: element.featureStatus,
            verifiedStatus: element.verifiedStatus,
            sundayStatus: element.sundayStatus,
            profiltStatus: element.profiltStatus,
            topTownStatus: element.topTownStatus,
            userSuspendedStatus: element.userSuspendedStatus,
            delStatus: element.delStatus,
            otp: element.otp,
            lastLoginIp: element.lastLoginIp,
            lastLogin: element.lastLogin,
            dateTime: element.dateTime,
          ));
        }
      }

      // Update the state if needed
      setState(() {});

      return allPropertyModel; // Return the model for further use
    } catch (e) {
      // Handle errors gracefully
      if (kDebugMode) {
        print("Error fetching property list: $e");
      }
      rethrow;
    }
  }

  _firstLoad(int pageNo) {
    setState(() => _isLoadingMore2 = true);
    print("object===> $_isLoadingMore");
    getAllPropertyList("Rent", pageNo);
    Future.delayed(Duration(seconds: 3))
        .then((value) => setState(() => _isLoadingMore2 = false));

    print("object===> $_isLoadingMore2");
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Initial data load
    _firstLoad(_pageNo);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() => _isLoadingMore = true);
      _pageNo++;
      getAllPropertyList("Rent", _pageNo).then((value) {
        setState(() => _isLoadingMore = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const NormalAppBar(title: "New Test"),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _pageNo = 1;
              _newList.clear();
            });
            _firstLoad(_pageNo);
          },
          child: _isLoadingMore2 == true
              ? buildShimmerLoading()
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _newList?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == _newList.length - 1) {
                      // Show a circular progress indicator at the end of the list
                      return const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return ListTile(
                      title: Text(
                        "Title :\n${_newList[index].title}",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      leading: CircleAvatar(
                        child: Text(
                          _newList[index].serviceId.toString(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    );
                  },
                ),
        ));
  }

  Widget buildShimmerLoading() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20.0,
              color: Colors.white,
            ),
          ),
          leading: CircleAvatar(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 40,
                width: 40,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
