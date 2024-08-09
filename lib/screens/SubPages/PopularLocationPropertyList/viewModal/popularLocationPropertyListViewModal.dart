import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/UserPropertyDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../data/modal/FavoriteAddModel.dart';
import '../../../../helper/GetStorageHelper.dart';

class PopularLocationPropertyListViewModal extends ChangeNotifier {
  final apiServices = NetworkApiServices();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    print("loading====> $_isLoading");
  }

  bool _isFilter = false;

  bool get isFilter => _isFilter;

  setIsFilter() {
    _isFilter = !_isFilter;
    if (kDebugMode) {
      print("Filter $_isFilter");
    }
    notifyListeners();
  }

  bool _isSearchBox = false;

  bool get isSearchBox => _isSearchBox;

  setIsSearchBox() {
    _isSearchBox = !_isSearchBox;
    if (kDebugMode) {
      print("IsSearch Box===> $_isSearchBox");
    }
    notifyListeners();
  }

  int? _categoryID;

  int? get categoryID => _categoryID;

  int? _isVerified = 0;

  int? get isVerified => _isVerified;

  setIsVerified(int value) {
    // _isVerified = !_isVerified;
    _isVerified = value;
    if (kDebugMode) {
      print("Verified $_isVerified");
    }
    notifyListeners();
  }

  bool _isSuperAgent = false;

  bool get isSuperAgent => _isSuperAgent;

  setIsSuperAgent() {
    _isSuperAgent = !_isSuperAgent;
    if (kDebugMode) {
      print("SuperAgent $_isSuperAgent");
    }
    notifyListeners();
  }

  final List<String> _selectedAreas = [];

  List<String> get selectedAreas => _selectedAreas;

  void toggleSelectedArea(String area) {
    if (_selectedAreas.contains(area)) {
      _selectedAreas.remove(area);
    } else {
      _selectedAreas.add(area);
    }
    if (kDebugMode) {
      print("SelectedAreas: $_selectedAreas");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedArea(String area) {
    return _selectedAreas.contains(area);
  }

  // Select Property Type

  final List<String> _selectedPropertyType = [];

  List<String> get selectedPropertyType => _selectedPropertyType;

  void toggleSelectedPropertyType(String pType) {
    if (_selectedPropertyType.contains(pType)) {
      _selectedPropertyType.remove(pType);
    } else {
      _selectedPropertyType.add(pType);
    }
    if (kDebugMode) {
      print("Selected P Type : $_selectedPropertyType");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedPType(String pType) {
    return _selectedPropertyType.contains(pType);
  }

  // Type
  final List<String> _selectedSubPropertyType = [];

  List<String> get selectedSubPropertyType => _selectedSubPropertyType;

  void toggleSelectedSubPropertyType(String spType) {
    if (_selectedSubPropertyType.contains(spType)) {
      _selectedSubPropertyType.remove(spType);
    } else {
      _selectedSubPropertyType.add(spType);
    }
    if (kDebugMode) {
      print("Selected Sub Property Type : $_selectedSubPropertyType");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedSubPropertyType(String spType) {
    return _selectedSubPropertyType.contains(spType);
  }

  // ByBuilder
  final List<String> _selectedByBuilder = [];

  List<String> get selectedByBuilder => _selectedByBuilder;

  void toggleSelectedByBuilder(String builderType) {
    if (_selectedByBuilder.contains(builderType)) {
      _selectedByBuilder.remove(builderType);
    } else {
      _selectedByBuilder.add(builderType);
    }
    if (kDebugMode) {
      print("Selected by builder : $_selectedByBuilder");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedByBuilder(String builderType) {
    return _selectedByBuilder.contains(builderType);
  }

  // BHK Types

  final List<String> _selectedBHKType = [];

  List<String> get selectedBHKType => _selectedBHKType;

  void toggleSelectedBHKType(String bhkType) {
    if (_selectedBHKType.contains(bhkType)) {
      _selectedBHKType.remove(bhkType);
    } else {
      _selectedBHKType.add(bhkType);
    }
    if (kDebugMode) {
      print("Selected BHK Type : $_selectedBHKType");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedBHKType(String bhkType) {
    return _selectedBHKType.contains(bhkType);
  }

  //Construction Type
  final List<String> _selectedConstructionType = [];

  List<String> get selectedConstructionType => _selectedConstructionType;

  void toggleSelectedConstructionType(String cType) {
    if (_selectedConstructionType.contains(cType)) {
      _selectedConstructionType.remove(cType);
    } else {
      _selectedConstructionType.add(cType);
    }
    if (kDebugMode) {
      print("Selected Construction Type : $_selectedConstructionType");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedConstructionType(String cType) {
    return _selectedConstructionType.contains(cType);
  }

  //Property Interior
  final List<String> _selectedPropertyInterior = [];

  List<String> get selectedPropertyInterior => _selectedPropertyInterior;

  void toggleSelectedPropertyInterior(String piType) {
    if (_selectedPropertyInterior.contains(piType)) {
      _selectedPropertyInterior.remove(piType);
    } else {
      _selectedPropertyInterior.add(piType);
    }
    if (kDebugMode) {
      print("Selected Property Interior : $_selectedPropertyInterior");
    }
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedPropertyInterior(String piType) {
    return _selectedPropertyInterior.contains(piType);
  }

  bool _isVoiceEnable = false;

  bool get isVoiceEnable => _isVoiceEnable;

  setVoiceEnable(bool value) {
    _isVoiceEnable = value;
    notifyListeners();
    print("isVoiceEnable $_isVoiceEnable");
  }

  bool _isAvailable = false;

  bool get isAvailable => _isAvailable;

  setIsAvailable(bool value) {
    _isAvailable = value;
    notifyListeners();
    print("isAvaliable $_isAvailable");
  }

  RangeValues _currentRangeValues = RangeValues(50000, 8000000);
  SfRangeValues _valuesPrice1 = SfRangeValues(50000, 120000000);

  SfRangeValues get valuesPrice1 => _valuesPrice1;

  RangeValues get currentRangeValues => _currentRangeValues;

  RangeValues _currentRangeValues3 = RangeValues(50000, 8000000);

  RangeValues get currentRangeValues3 => _currentRangeValues3;

  setRangeValue(RangeValues value) {
    _currentRangeValues = value;
    notifyListeners();
  }

  setRangePriceRangeValue(SfRangeValues value) {
    _valuesPrice1 = value;
    notifyListeners();
  }

  RangeValues _currentRangeValues2 = RangeValues(500, 8000000);

  RangeValues get currentRangeValues2 => _currentRangeValues2;

  setAreaValue(RangeValues value) {
    _currentRangeValues2 = value;
    notifyListeners();
  }

  AllPropertyModel _allPropertyModel = AllPropertyModel();

  AllPropertyModel get allPropertyModel => _allPropertyModel;

  Future<AllPropertyModel> getActualFilterProperty(var data) async {
    setIsLoading(true);
    try {
      final response = await apiServices.getPostApiResponse(
          false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getFilterPropertyData}?user_id=${box.read("cust_id_raipurHomes")}",
          data);
      _allPropertyModel = AllPropertyModel.fromJson(response);
      if (kDebugMode) {
        print("Property Filter Data response========> $response");
      }
      setIsLoading(false);
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      setIsLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  String formatLabel(double value) {
    if (value >= 10000000) {
      return '${(value / 10000000).toStringAsFixed(1)}cr';
    } else if (value >= 100000) {
      return '${(value / 100000).toStringAsFixed(1)} lakh';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toString();
    }
  }

  Future<AllPropertyModel> getAllPropertyList(String category) async {
    setIsLoading(true);
    try {
      final response = await apiServices.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getAllPropertyList}?category=$category&user_id=${box.read("cust_id_raipurHomes").toString()}");
      if (kDebugMode) {
        print("all property response========> $response");
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

  UserPropertyDataModel _getUserPropertyDataModel = UserPropertyDataModel();

  UserPropertyDataModel get getUserPropertyDataModel =>
      _getUserPropertyDataModel;

  Future<UserPropertyDataModel> getUserProperty(bool isSecure) async {
    setIsLoading(true);
    print("get user property detailssssss");
    try {
      final response = await apiServices.getGetApiResponse(isSecure,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getPostProperty}?userid=${box.read("cust_id_raipurHomes").toString()}");
      print("User Properties =====> $response");
      _getUserPropertyDataModel = UserPropertyDataModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _getUserPropertyDataModel;
    } catch (e) {
      setIsLoading(false);
      notifyListeners();
      rethrow;
    }
  }
}
