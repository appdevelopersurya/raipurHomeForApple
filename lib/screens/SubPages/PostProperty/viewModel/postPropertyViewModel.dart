import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/FilterToolsDataModel.dart';
import 'package:fmraipuromes/data/modal/PropertySubTypeDataModel.dart';
import 'package:fmraipuromes/data/modal/menuItem.dart';
import 'package:fmraipuromes/data/modal/postPropertyResponseModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/utils.dart';

class PostPropertyViewModel extends ChangeNotifier {
  MenuItem? _selectedCategory;
  MenuItem? get selectedCategory => _selectedCategory;
  void onCategorySelected(MenuItem selectedCategory) {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  Data1? _selectedPType;
  Data1? get selectedPType => _selectedPType;

  void onpTypeSelected(Data1 selectedPType) {
    _selectedPType = selectedPType;
    notifyListeners();
  }

  Type? _selectType;
  Type? get selectType => _selectType;

  void onSelectTypes(Type onSelectType) {
    _selectType = onSelectType;
    notifyListeners();
  }

  final apiService = NetworkApiServices();
  PostPropertyResponseModel _postPropertyResponseModel =
      PostPropertyResponseModel();
  PostPropertyResponseModel get postPropertyResponseModel =>
      _postPropertyResponseModel;

  Future<PostPropertyResponseModel> postPropertyApi(
    bool isSecure,
    var data,
    String fieldName,
    String imagePath,
  ) async {
    try {
      final response = await apiService.postimage(
          false,
          AppUrl.baseUrl + AppUrl.authEndPoints.postProperty,
          data,
          fieldName,
          imagePath);
      print("response===> $response");
      _postPropertyResponseModel = PostPropertyResponseModel.fromJson(response);
      return _postPropertyResponseModel;
    } catch (e) {
      print(e.toString());
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<String> deleteProperty(String propertyId) async {
    try {
      final response = await apiService.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.deletePostProperty}/$propertyId");
      return response["message"].toString();
    } catch (e) {
      Utils.toastMessage("Something went wrong", errorColor);
      return "Something went wrong";
    }
  }

  List<Category> _category = [];
  List<Category> get category => _category;

  List<Data1> _pSubType = [];
  List<Data1> get pSubType => _pSubType;

  List<Type> _pType = [];
  List<Type> get pType => _pType;

  FilterToolsDataModel _filterToolsDataModel = FilterToolsDataModel();
  FilterToolsDataModel get filterToolsDataModel => _filterToolsDataModel;

  Future<FilterToolsDataModel> fetchFilterTools() async {
    try {
      final response = await apiService.getGetApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.getFilterTools);
      print("filter data response ====> $response");
      _filterToolsDataModel = FilterToolsDataModel.fromJson(response);
      // _filterToolsDataModel.location?.forEach(
      //   (element) {
      //     _locations.add(Location(name: element.name, id: element.id));
      //   },
      // );
      _category = _filterToolsDataModel.category!;
      _pType = _filterToolsDataModel.type!;
      notifyListeners();
      return _filterToolsDataModel;
    } catch (e) {
      rethrow;
    }
  }

  PropertySubTypeDataModel _propertySubTypeDataModel =
      PropertySubTypeDataModel();
  PropertySubTypeDataModel get propertySubTypeDataModel =>
      _propertySubTypeDataModel;

  Future<PropertySubTypeDataModel> fetchDependencyTools(var data) async {
    try {
      final response = await apiService.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.dependencySelect, data);
      print("filter data response ====> $response");
      _propertySubTypeDataModel = PropertySubTypeDataModel.fromJson(response);
      _pSubType = _propertySubTypeDataModel.data!;
      notifyListeners();
      return _propertySubTypeDataModel;
    } catch (e) {
      rethrow;
    }
  }

  void clearFunction() {
    _selectedCategory = null;
    _selectedPType = null;
    _selectType = null;
    notifyListeners();
  }
}
