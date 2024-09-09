import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/OurProjectDetailsDataModel.dart';
import 'package:fmraipuromes/data/modal/OutProjectDataModels.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

import '../../../../data/modal/FavoriteAddModel.dart';
import '../../../../helper/GetStorageHelper.dart';

class OurProjectsViewModel extends ChangeNotifier {
  final _apiNetworkServices = NetworkApiServices();

  OurProjectDataModels _ourProjectDataModels = OurProjectDataModels();

  OurProjectDataModels get ourProjectDataModels => _ourProjectDataModels;

  Future<OurProjectDataModels> getProjectList() async {
    try {
      final response = await _apiNetworkServices.getGetApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.ourProjects);
      print("Our Projects Response Data=========> $response");
      _ourProjectDataModels = OurProjectDataModels.fromJson(response);
      return _ourProjectDataModels;
    } catch (e) {
      rethrow;
    }
  }

  Future<OurProjectDataModels> getProjectListForPage() async {
    _isLodingDetailsPage = true;
    try {
      final response = await _apiNetworkServices.getGetApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.ourProjects);
      print("Our Projects Response Data=========> $response");
      _ourProjectDataModels = OurProjectDataModels.fromJson(response);
      _isLodingDetailsPage = false;
      notifyListeners();
      return _ourProjectDataModels;
    } catch (e) {
      _isLodingDetailsPage = false;
      notifyListeners();
      rethrow;
    }
  }

  bool _isLodingDetailsPage = false;

  bool get isLodingDetailsPage => _isLodingDetailsPage;

  OurProjectDetailsDataModel _ourProjectDetailsDataModels =
      OurProjectDetailsDataModel();

  OurProjectDetailsDataModel get ourProjectDetailsDataModels =>
      _ourProjectDetailsDataModels;

  Future<OurProjectDetailsDataModel> getProjectDetails(int projectID) async {
    _isLodingDetailsPage = true;
    try {
      final response = await _apiNetworkServices.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.ourProjectsDetails}/$projectID");
      print("Our Projects Response Data=========> $response");
      _ourProjectDetailsDataModels =
          OurProjectDetailsDataModel.fromJson(response);
      _isLodingDetailsPage = false;
      notifyListeners();
      return _ourProjectDetailsDataModels;
    } catch (e) {
      _isLodingDetailsPage = false;
      notifyListeners();
      rethrow;
    }
  }

  // Function to increase quantity for a specific item at index
  void setIsFav(String serviceID, int index) async {
    if (_ourProjectDetailsDataModels
            .allproperty?[index].getBookMarkedProperty ==
        null) {
      print("without null===========>");
      addBookmark(serviceID);
      _ourProjectDetailsDataModels.allproperty?[index].setBookmark = true;
      _ourProjectDetailsDataModels.allproperty?[index].loadingUpdate = true;
      notifyListeners();
    } else {
      print("with null===========>");
      addBookmark(serviceID);
      _ourProjectDetailsDataModels.allproperty?[index].setBookmark = null;
      _ourProjectDetailsDataModels.allproperty?[index].loadingUpdate = true;

      notifyListeners();
    }
    Future.delayed(const Duration(seconds: 1)).then((value) {
      _ourProjectDetailsDataModels.allproperty?[index].loadingUpdate = false;
      notifyListeners();
    });
  }

  FavoriteAddModel _favoriteAddModel = FavoriteAddModel();

  FavoriteAddModel get favoriteAddModel => FavoriteAddModel();

  Future<void> addBookmark(String serviceID) async {
    var body = {
      "user_id": "${box.read("cust_id_raipurHomes")}",
      "property_id": "${serviceID}"
    };

    try {
      final response = await _apiNetworkServices.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.setFavorite, body);
      _favoriteAddModel = FavoriteAddModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Function to increase quantity for a specific item at index
  void setIsFavThroughRecentProperty(String serviceID, int index) async {
    if (_ourProjectDetailsDataModels
            .letestproperty?[index].getBookMarkedProperty ==
        null) {
      print("without null===========>");
      addBookmark(serviceID);
      _ourProjectDetailsDataModels.letestproperty?[index].setBookmark = true;
      _ourProjectDetailsDataModels.letestproperty?[index].loadingUpdate = true;
      notifyListeners();
    } else {
      print("with null===========>");
      addBookmark(serviceID);
      _ourProjectDetailsDataModels.letestproperty?[index].setBookmark = null;
      _ourProjectDetailsDataModels.letestproperty?[index].loadingUpdate = true;

      notifyListeners();
    }
    Future.delayed(const Duration(seconds: 1)).then((value) {
      _ourProjectDetailsDataModels.letestproperty?[index].loadingUpdate = false;
      notifyListeners();
    });
  }
}
