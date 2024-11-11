import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';
import 'package:fmraipuromes/data/modal/FavoriteAddModel.dart';
import 'package:fmraipuromes/data/modal/FilterToolsDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GetFilterTools extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
  }

  final _apiService = NetworkApiServices();

  List<Location> _locations = [];

  List<Location> get locations => _locations;

  void filterLocationSearch(String searchKey) {
    List<Location>? result = [];
    if (searchKey.isEmpty) {
      result = _filterToolsDataModel.location;
    } else {
      result = _filterToolsDataModel.location
          ?.where(
            (element) =>
                element.name!.toLowerCase().contains(searchKey.toLowerCase()),
          )
          .toList();
    }
    _locations = result!;
    print("locations====> ${_locations.map(
      (element) => element.name,
    )}");

    notifyListeners();
  }

  List<PropertyType> _propertyTypes = [];

  List<PropertyType> get propertyTypes => _propertyTypes;

  void filterPropertyTypeSearch(String searchKey) {
    List<PropertyType>? result = [];
    if (searchKey.isEmpty) {
      result = _filterToolsDataModel.propertyType;
    } else {
      result = _filterToolsDataModel.propertyType
          ?.where(
            (element) =>
                element.name!.toLowerCase().contains(searchKey.toLowerCase()),
          )
          .toList();
    }
    _propertyTypes = result!;
    if (kDebugMode) {
      result.forEach(
        (element) {
          print("psubtyep search=====> ${element.name}");
        },
      );
    }
    notifyListeners();
  }

  void resetSearch() {
    _propertyTypes = _filterToolsDataModel.propertyType ?? [];
    _locations = _filterToolsDataModel.location ?? [];
    notifyListeners();
  }

  FilterToolsDataModel _filterToolsDataModel = FilterToolsDataModel();

  FilterToolsDataModel get filterToolsDataModel => _filterToolsDataModel;

  Future<FilterToolsDataModel> fetchFilterTools() async {
    try {
      final response = await _apiService.getGetApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.getFilterTools);
      print("filter data response ====> $response");
      _filterToolsDataModel = FilterToolsDataModel.fromJson(response);
      // _filterToolsDataModel.location?.forEach(
      //   (element) {
      //     _locations.add(Location(name: element.name, id: element.id));
      //   },
      // );
      _locations = _filterToolsDataModel.location!;
      _propertyTypes = _filterToolsDataModel.propertyType!;
      notifyListeners();
      return _filterToolsDataModel;
    } catch (e) {
      rethrow;
    }
  }

  AllPropertyModel _allPropertyModel = AllPropertyModel();

  AllPropertyModel get allPropertyModel => _allPropertyModel;

  Future<AllPropertyModel> fetchFilteredData(var data) async {
    setIsLoading(true);
    print("filtered body ====> $data");
    try {
      final response = await _apiService.getPostApiResponse(
          false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getFilterPropertyData}?user_id=${box.read("cust_id_raipurHomes")}",
          data);
      print("filtered response ====> $response");
      _allPropertyModel = AllPropertyModel.fromJson(response);
      print("data len==> ${_allPropertyModel.data?.length}");
      setIsLoading(false);
      notifyListeners();
      return _allPropertyModel;
    } catch (e) {
      rethrow;
    }
  }

  bool _isFilter = false;

  bool get isFilter => _isFilter;

  setIsFilter() {
    _isFilter = !_isFilter;

    print("Filter $_isFilter");

    notifyListeners();
  }

  bool _isSearchBox = false;

  bool get isSearchBox => _isSearchBox;

  setIsSearchBox() {
    _isSearchBox = !_isSearchBox;

    print("IsSearch Box===> $_isSearchBox");

    notifyListeners();
  }

  int? _categoryID;

  int? get categoryID => _categoryID;

  String? _isVerified = "BUY"; // Default selection for "BUY"

  String? get isVerified => _isVerified;

  void setIsVerified(String value) {
    _isVerified = value;
    print("Verified $_isVerified");
    notifyListeners();
  }

  bool _isSuperAgent = false;

  bool get isSuperAgent => _isSuperAgent;

  setIsSuperAgent() {
    _isSuperAgent = !_isSuperAgent;
    print("SuperAgent $_isSuperAgent");
    notifyListeners();
  }

  final List<String> _selectedAreas = [];

  List<String> get selectedAreas => _selectedAreas;

  final List<String> _selectedAreaName = [];

  List<String> get selectedAreaName => _selectedAreaName;

  void toggleSelectedArea(String area, String name) {
    if (_selectedAreas.contains(area) && _selectedAreaName.contains(name)) {
      _selectedAreas.remove(area);
      _selectedAreaName.remove(name);
      print("selected removed area ${_selectedAreaName.length}");
    } else {
      _selectedAreas.add(area);
      _selectedAreaName.add(name);
    }

    print("SelectedAreas: $_selectedAreas-$selectedAreaName");

    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedArea(String area) {
    return _selectedAreas.contains(area);
  }

  // Select Property Type

  final List<String> _selectedPropertyType = [];

  List<String> get selectedPropertyType => _selectedPropertyType;

  final List<String> _selectedPropertyTypeName = [];

  List<String> get selectedPropertyTypeName => _selectedPropertyTypeName;

  void toggleSelectedPropertyType(String pType, String name) {
    bool isSelected = _selectedPropertyType.contains(pType) &&
        _selectedPropertyTypeName.contains(name);

    if (isSelected) {
      // Remove property type and name if already selected
      _selectedPropertyType.remove(pType);
      _selectedPropertyTypeName.remove(name);
    } else {
      // Add property type and name if not selected
      _selectedPropertyType.add(pType);
      _selectedPropertyTypeName.add(name);
    }

    // Debug output to track selected property types
    print(
        "Selected Property Type: $_selectedPropertyType-$_selectedPropertyTypeName");

    // Notify listeners to update UI
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedPType(String pType) {
    return _selectedPropertyType.contains(pType);
  }

  // Type
  final List<String> _selectedSubPropertyType = [];

  List<String> get selectedSubPropertyType => _selectedSubPropertyType;

  final List<String> _selectedPropertySubTypeName = [];

  List<String> get selectedPropertySubTypeName => _selectedPropertySubTypeName;

  void toggleSelectedSubPropertyType(String spType, String name) {
    if (_selectedSubPropertyType.contains(spType) &&
        _selectedPropertySubTypeName.contains(name)) {
      _selectedSubPropertyType.remove(spType);
      _selectedPropertySubTypeName.remove(name);
    } else {
      _selectedSubPropertyType.add(spType);
      _selectedPropertySubTypeName.add(name);
    }
    print(
        "Selected Sub Property Type : $_selectedSubPropertyType-$_selectedPropertySubTypeName");
    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedSubPropertyType(String spType) {
    return _selectedSubPropertyType.contains(spType);
  }

  // ByBuilder
  final List<String> _selectedByBuilder = [];
  final List<String> _selectedByBuilderName = [];

  List<String> get selectedByBuilder => _selectedByBuilder;

  List<String> get selectedByBuilderName => _selectedByBuilderName;

  void toggleSelectedByBuilder(String builderType, String builderTypeName) {
    if (_selectedByBuilder.contains(builderType) &&
        _selectedByBuilderName.contains(builderTypeName)) {
      _selectedByBuilder.remove(builderType);
      _selectedByBuilderName.remove(builderTypeName);
    } else {
      _selectedByBuilder.add(builderType);
      _selectedByBuilderName.add(builderTypeName);
    }

    print("Selected by builder : $_selectedByBuilder-$selectedByBuilderName");

    notifyListeners();
  }

  // Method to check if an area is selected
  bool isSelectedByBuilder(String builderType) {
    return _selectedByBuilder.contains(builderType);
  }

// BHK Types

  final List<String> _selectedBHKType = [];

  List<String> get selectedBHKType => _selectedBHKType;

  void toggleSelectedBHKType(String bhkNumber) {
    if (_selectedBHKType.contains('"$bhkNumber"')) {
      _selectedBHKType.remove('"$bhkNumber"');
    } else {
      _selectedBHKType.add('"$bhkNumber"');
    }
    // Print with quotes around the result
    print("Selected BHK Type: $_selectedBHKType");
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

    print("Selected Construction Type : $_selectedConstructionType");

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

    print("Selected Property Interior : $_selectedPropertyInterior");

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
    print("isAvailable $_isAvailable");
  }

  var areaRangeValue1 = 0.0;
  var areaRangeValue2 = 0.0;
  SfRangeValues _valuesAreaRange = const SfRangeValues(500.0, 30000.0);

  SfRangeValues get valuesAreaRange => _valuesAreaRange;

  setAreaValue(SfRangeValues value) {
    _valuesAreaRange = value;
    areaRangeValue1 = _valuesAreaRange.start;
    areaRangeValue2 = _valuesAreaRange.end;
    notifyListeners();
  }

  var priceRangeValueRent1 = 0.0;
  var priceRangeValueRent2 = 0.0;
  SfRangeValues _valuesPriceRent = const SfRangeValues(5000.0, 500000.0);

  SfRangeValues get valuesPriceRent => _valuesPriceRent;

  setRangeValueForRent(SfRangeValues value) {
    _valuesPriceRent = value;
    priceRangeValueRent1 = _valuesPriceRent.start;
    priceRangeValueRent2 = _valuesPriceRent.end;
    notifyListeners();
  }

  var priceRangeValueBuy1 = 0.0;
  var priceRangeValueBuy2 = 0.0;

  SfRangeValues _valuesPriceBuy = const SfRangeValues(1000000.0, 50000000.0);

  SfRangeValues get valuesPriceBuy => _valuesPriceBuy;

  setRangeValueForBuy(SfRangeValues value) {
    _valuesPriceBuy = value;
    priceRangeValueBuy1 = _valuesPriceBuy.start;
    priceRangeValueBuy2 = _valuesPriceBuy.end;
    notifyListeners();
  }

  var areaRangeKm1 = 0.0;
  var areaRangeKm2 = 0.0;
  SfRangeValues _valuesAreaRangeKm = const SfRangeValues(0.0, 5.0);

  SfRangeValues get valuesAreaRangeKm => _valuesAreaRangeKm;

  setAreaKmValue(SfRangeValues value) {
    _valuesAreaRangeKm = value;
    areaRangeKm1 = _valuesAreaRangeKm.start;
    areaRangeKm2 = _valuesAreaRangeKm.end;
    notifyListeners();
  }

  String _priceMinTitle = "No Min";

  String get priceMinTitle => _priceMinTitle;

  double _priceMinValue = 0.0;

  double get priceMinValue => _priceMinValue;

  void setPriceMinValue(String priceTitle, double actualPrice) {
    _priceMinTitle = priceTitle;
    _priceMinValue = actualPrice;
    priceRangeValueBuy1 = actualPrice;
    notifyListeners();
  }

  String _priceMaxTitle = "No Max";

  String get priceMaxTitle => _priceMaxTitle;

  double _priceMaxValue = 0.0;

  double get priceMaxValue => _priceMaxValue;

  void setPriceMaxValue(String priceTitle, double actualPrice) {
    _priceMaxTitle = priceTitle;
    _priceMaxValue = actualPrice;
    priceRangeValueBuy2 = actualPrice;
    notifyListeners();
  }

  String _sqftMinTitle = "No Min";

  String get sqftMinTitle => _sqftMinTitle;

  double _sqftMinValue = 0.0;

  double get sqftMinValue => _sqftMinValue;

  void setSqftMinValue(String priceTitle, double actualPrice) {
    _sqftMinTitle = priceTitle;
    _sqftMinValue = actualPrice;
    areaRangeValue1 = actualPrice;
    notifyListeners();
  }

  String _sqftMaxTitle = "No Max";

  String get sqftMaxTitle => _sqftMaxTitle;

  double _sqftMaxValue = 0.0;

  double get sqftMaxValue => _sqftMaxValue;

  void setSqftMaxValue(String priceTitle, double actualPrice) {
    _sqftMaxTitle = priceTitle;
    _sqftMaxValue = actualPrice;
    areaRangeValue2 = actualPrice;
    notifyListeners();
  }

  double? _disKm = 0.0;

  double? get disKm => _disKm;

  setDistKm(double value) {
    _disKm = value;
    notifyListeners();
  }

  void clearAllFilters() {
    _selectedAreas.clear();
    _selectedAreaName.clear();
    _selectedPropertyType.clear();
    _selectedPropertyTypeName.clear();
    _selectedSubPropertyType.clear();
    _selectedPropertySubTypeName.clear();
    _selectedByBuilder.clear();
    _selectedByBuilderName.clear();
    _selectedBHKType.clear();
    _selectedConstructionType.clear();
    _selectedPropertyInterior.clear();

    // Resetting range and min/max values
    areaRangeValue1 = 0.0;
    areaRangeValue2 = 0.0;
    _valuesAreaRange = const SfRangeValues(500.0, 30000.0);

    priceRangeValueRent1 = 0.0;
    priceRangeValueRent2 = 0.0;
    _valuesPriceRent = const SfRangeValues(5000.0, 500000.0);

    priceRangeValueBuy1 = 0.0;
    priceRangeValueBuy2 = 0.0;
    _valuesPriceBuy = const SfRangeValues(1000000.0, 50000000.0);

    areaRangeKm1 = 0.0;
    areaRangeKm2 = 0.0;
    _valuesAreaRangeKm = const SfRangeValues(0.0, 5.0);

    _priceMinTitle = "No Min";
    _priceMinValue = 0.0;

    _priceMaxTitle = "No Max";
    _priceMaxValue = 0.0;

    _sqftMinTitle = "No Min";
    _sqftMinValue = 0.0;

    _sqftMaxTitle = "No Max";
    _sqftMaxValue = 0.0;

    _disKm = null;

    _isFilter = false;
    _isSearchBox = false;
    _categoryID = null;
    _isVerified = "BUY"; // Resetting to default
    _isSuperAgent = false;
    _isVoiceEnable = false;
    _isAvailable = false;

    notifyListeners();
  }

  FavoriteAddModel get favoriteAddModel => FavoriteAddModel();

  Future<void> addBookmark(String serviceID) async {
    var body = {
      "user_id": "${box.read("cust_id_raipurHomes")}",
      "property_id": "${serviceID}"
    };

    try {
      final response = await _apiService.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.setFavorite, body);
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

  String _townId = "";

  String get townId => _townId;

  setTownId(String value) {
    _townId = value;
    notifyListeners();
  }

  String _searchKeyword = "";

  String get searchKeyword => _searchKeyword;

  setSearchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }
}
