import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/FavoriteAddModel.dart';
import 'package:fmraipuromes/data/modal/SuggestionTextModel.dart';
import 'package:fmraipuromes/data/modal/trendingAreaModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/services/locationServices/fetchCurrentLocation.dart';

import '../../../data/modal/bannerDataModel.dart';

class HomeVIewController extends ChangeNotifier {
  final apiServices = NetworkApiServices();

  int? _tabIndex;

  int? get tabIndex => _tabIndex;

  setIndex(int? _tabIndex) {
    this._tabIndex = _tabIndex;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _coordinates = "No Location Found";
  String _address = "No address found";
  bool _isScanning = false;

  String get coordinates => _coordinates;

  String get address => _address;

  bool get isScanning => _isScanning;

  setIsScanning(bool value) {
    _isScanning = value;
    // notifyListeners();
    print("Scanning ====> $isScanning");
  }

  setIsLoading(bool value) {
    _isLoading = value;
    // notifyListeners();
    print("Loading ====> $_isLoading");
  }

  final LocationService _currentLocation = LocationService();

  bool _isLoadingLocation = false;

  bool get isLoadingLocation => _isLoadingLocation;

  Future<String> checkPermission() async {
    _isLoadingLocation = true;
    notifyListeners(); // Notify immediately after setting to true to update the UI

    String? result = await _currentLocation.checkPermission();
    print("Permission Result: $result");

    if (result != null && result.contains("Coordinates")) {
      List<String> lines = result.split('\n');
      _coordinates = lines[0].replaceFirst('Coordinates: ', '');
      _address = lines[1].replaceFirst('Address: ', '');
      print("addressss========> $_address");
    } else {
      _coordinates = "No Location Found";
      _address = "No address found";
      print("Location Error: $result");
    }
    _isLoadingLocation = false;
    notifyListeners(); // Notify again after finishing to remove the indicator
    return result ?? "";
  }

  BannerDataModel _bannerDataModel = BannerDataModel();

  BannerDataModel get bannerDataModel => _bannerDataModel;

  Future<BannerDataModel> getBanner(bool isSecure) async {
    setIsLoading(true);
    try {
      final response = await apiServices.getGetApiResponse(
          isSecure, AppUrl.baseUrl + AppUrl.authEndPoints.getBanner);
      _bannerDataModel = BannerDataModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _bannerDataModel;
    } catch (e) {
      setIsLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  TrendingAreaModel _trendingAreaModel = TrendingAreaModel();

  TrendingAreaModel get trendingAreaModel => _trendingAreaModel;

  Future<TrendingAreaModel> getTrendingArea(bool isSecure) async {
    try {
      final response = await apiServices.getGetApiResponse(
          isSecure, AppUrl.baseUrl + AppUrl.authEndPoints.getTrendingArea);
      print("area data =====> $response");
      _trendingAreaModel = TrendingAreaModel.fromJson(response);
      notifyListeners();
      return _trendingAreaModel;
    } catch (e) {
      rethrow;
    }
  }

  AllPropertyModel _allPropertyModel = AllPropertyModel();

  AllPropertyModel get allPropertyModel => _allPropertyModel;

  Future<AllPropertyModel> getFeatureProperty(
      bool isSecure, String pType) async {
    try {
      final response = pType == "Buy"
          ? await apiServices.getGetApiResponse(isSecure,
              "${AppUrl.baseUrl}${AppUrl.authEndPoints.getFeaturedPropertySell}?user_id=${box.read("cust_id_raipurHomes")}")
          : await apiServices.getGetApiResponse(isSecure,
              "${AppUrl.baseUrl}${AppUrl.authEndPoints.getFeaturedPropertyRent}?user_id=${box.read("cust_id_raipurHomes")}");
      print("Feature Properties =====> $response");
      _allPropertyModel = AllPropertyModel.fromJson(response);
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      rethrow;
    }
  }

  SuggestionTextModel _suggestionTextModel = SuggestionTextModel();

  SuggestionTextModel get suggestionTextModel => _suggestionTextModel;

  Future<SuggestionTextModel> getSuggestionData(bool isSecure) async {
    try {
      final response = await apiServices.getGetApiResponse(isSecure,
          AppUrl.baseUrl + AppUrl.authEndPoints.getSuggestionDataItem);
      print("Suggestion Data =====> $response");
      _suggestionTextModel = SuggestionTextModel.fromJson(response);
      notifyListeners();
      return _suggestionTextModel;
    } catch (e) {
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
      final response = await apiServices.getPostApiResponse(
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

  double? _downloadProgress;

  double? get downloadProgress => _downloadProgress;

  setDownloadProgress(double? progress) {
    _downloadProgress = progress;
    notifyListeners();
  }
}
