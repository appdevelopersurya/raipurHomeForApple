import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/FavoriteAddModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class BookMarkController extends ChangeNotifier {
  final apiService = NetworkApiServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  AllPropertyModel _allPropertyModel = AllPropertyModel();
  AllPropertyModel get allPropertyModel => _allPropertyModel;

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

  Future<AllPropertyModel> getBookMarkedData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getBookMarked}?user_id=${box.read('cust_id_raipurHomes').toString()}");
      print("fav reponse =====> $response");
      _allPropertyModel = AllPropertyModel.fromJson(response);
      _isLoading = false;
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
