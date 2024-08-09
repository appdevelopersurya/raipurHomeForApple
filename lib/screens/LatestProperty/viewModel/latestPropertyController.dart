import 'package:flutter/foundation.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/FavoriteAddModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class LatestPropertyController extends ChangeNotifier {
  final apiService = NetworkApiServices();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    if (kDebugMode) {
      print("latest isLoading $isLoading");
    }
  }

  AllPropertyModel _allPropertyModel = AllPropertyModel();
  AllPropertyModel get allPropertyModel => _allPropertyModel;

  Future<AllPropertyModel> getLatestProperty(bool isSecure) async {
    setIsLoading(true);
    try {
      final response = await apiService.getGetApiResponse(isSecure,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getLatestProperty}?user_id=${box.read("cust_id_raipurHomes")}");
      if (kDebugMode) {
        print("latest property =====> $response ");
      }
      _allPropertyModel = AllPropertyModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      setIsLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  FavoriteAddModel _favoriteAddModel = FavoriteAddModel();
  FavoriteAddModel get favoriteAddModel => FavoriteAddModel();

  Future<void> addBookmark(String serviceID) async {
    var body = {
      "user_id": "${box.read("cust_id_raipurHomes")}",
      "property_id": "${serviceID}"
    };

    try {
      final response = await apiService.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.setFavorite, body);
      _favoriteAddModel = FavoriteAddModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Function to increase quantity for a specific item at index
  void setIsFav(String serviceID, int index) async {
    if (_allPropertyModel.data?[index].getBookMarkedProperty == null) {
      print("without null===========>");
      addBookmark(serviceID);
      _allPropertyModel.data?[index].setBookmark = true;
      _allPropertyModel.data?[index].loadingUpdate = true;

      notifyListeners();
    } else {
      print("with null===========>");
      addBookmark(serviceID);
      _allPropertyModel.data?[index].setBookmark = null;
      _allPropertyModel.data?[index].loadingUpdate = true;

      notifyListeners();
    }
    Future.delayed(const Duration(seconds: 1)).then((value) {
      _allPropertyModel.data?[index].loadingUpdate = false;
      notifyListeners();
    });
  }
}
