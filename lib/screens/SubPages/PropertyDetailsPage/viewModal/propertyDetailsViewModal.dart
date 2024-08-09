import 'package:flutter/foundation.dart';
import 'package:fmraipuromes/data/modal/PorpertyDetailsDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class PropertyDetailsViewController extends ChangeNotifier {
  bool _isExpanded = false;
  bool _isExpandedTitle = false;
  bool _isExpandedSubtitle = false;

  bool get isExpanded => _isExpanded;

  bool get isExpandedTitle => _isExpandedTitle;

  bool get isExpandedSubtitle => _isExpandedSubtitle;

  setsExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  setExpandedTitle() {
    _isExpandedTitle = !_isExpandedTitle;
    notifyListeners();
  }

  setsExpandedSubtitle() {
    _isExpandedSubtitle = !_isExpandedSubtitle;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    print("Isloading====> $isLoading");
  }

  PorpertyDetailsDataModel _porpertyDetailsDataModel =
      PorpertyDetailsDataModel();

  PorpertyDetailsDataModel get porpertyDetailsDataModel =>
      _porpertyDetailsDataModel;
  final apiService = NetworkApiServices();

  Future<PorpertyDetailsDataModel> getPropertyDetails(
      bool isSecure, String propertyID) async {
    setIsLoading(true);
    try {
      final response = await apiService.getGetApiResponse(isSecure,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getSinglePropertyDetails}/${propertyID.toString()}?user_id=${box.read("cust_id_raipurHomes").toString()}&deviceIP=${box.read("rprHomesDeviceIP")}");
      if (kDebugMode) {
        print("property details ===> $response");
        print(
            "property suggestionProperty ===> ${response["suggestionProperty"]}");
      }
      _porpertyDetailsDataModel = PorpertyDetailsDataModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _porpertyDetailsDataModel;
    } catch (e) {
      setIsLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addBookmark(String serviceID) async {
    var body = {
      "user_id": "${box.read("cust_id_raipurHomes")}",
      "property_id": "${serviceID}"
    };
    try {
      final response = await apiService.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.setFavorite, body);
      // _favoriteAddModel = FavoriteAddModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Function to increase quantity for a specific item at index
  void setIsFav(String serviceID) async {
    if (_porpertyDetailsDataModel.data?.getBookMarkedProperty == null) {
      print("without null===========>");
      addBookmark(serviceID);
      _porpertyDetailsDataModel.data?.setBookmark = true;
      _porpertyDetailsDataModel.data?.loadingUpdate = true;
      notifyListeners();
    } else {
      print("with null===========>");
      addBookmark(serviceID);
      _porpertyDetailsDataModel.data?.setBookmark = null;
      _porpertyDetailsDataModel.data?.loadingUpdate = true;
      notifyListeners();
    }
    Future.delayed(const Duration(seconds: 1)).then((value) {
      _porpertyDetailsDataModel.data?.loadingUpdate = false;
      notifyListeners();
    });
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
