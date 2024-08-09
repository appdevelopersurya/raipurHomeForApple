import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../../../data/modal/FavoriteAddModel.dart';

class ExploreViewModel extends ChangeNotifier {
  final _apiServices = NetworkApiServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AllPropertyModel _allPropertyModel = AllPropertyModel();
  AllPropertyModel get allPropertyModel => _allPropertyModel;

  Future<AllPropertyModel> getExploreData() async {
    _isLoading = true;
    try {
      final response = await _apiServices.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.exploreView}?user_id=${box.read("cust_id_raipurHomes")}");
      if (kDebugMode) {
        print("explored data=======> $response");
      }
      _allPropertyModel = AllPropertyModel.fromJson(response);
      _isLoading = false;
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      _isLoading = false;
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
      final response = await _apiServices.getPostApiResponse(
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

  AnimationController? _controllerAnimation1;
  AnimationController? get controllerAnimation1 => _controllerAnimation1;

  bool _isExpandedSearch = false;
  bool get isExpandedSearch => _isExpandedSearch;

  initializeController(TickerProvider vsync) {
    _controllerAnimation1 = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
  }

  void disposeController() {
    _controllerAnimation1?.dispose();
  }

  void toggleSize(bool value) {
    if (_isExpandedSearch) {
      _controllerAnimation1?.reverse();
    } else {
      _controllerAnimation1?.forward();
    }
    _isExpandedSearch = value;
    print("_isExpandedSearch==> $_isExpandedSearch");
    notifyListeners();
  }

  Future<AllPropertyModel> fetchDependencyTools(var data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.dependencySelect, data);
      print("filter data response ====> $response");
      _allPropertyModel = AllPropertyModel.fromJson(response);
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      rethrow;
    }
  }

  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  String type = '(regions)';
  List _placeList = [];
  List get placeList => _placeList;

  sePlaceListClear() {
    _placeList.clear();
    notifyListeners();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() {
  //     _onChanged();
  //   });
  // }

  controllerInitializer(TextEditingController texController) {
    texController.addListener(() {
      onChanged(texController);
    });
  }

  onChanged(TextEditingController texController) {
    getSuggestion(texController.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDZiDCmwSZrqgD-cFz9LEMoIotAiZm7fE4";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken&type=$type';
    var response = await http.get(Uri.parse(request));
    print("response=======> ${response.body}");
    if (response.statusCode == 200) {
      _placeList = json.decode(response.body)['predictions'];
      notifyListeners();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  bool _isPlaceList = false;
  bool get isPlaceList => _isPlaceList;

  setIsPlaced(bool value) {
    _isPlaceList = value;
    notifyListeners();
  }
}
