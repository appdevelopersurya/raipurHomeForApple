import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/app_exceptions.dart';
import 'package:fmraipuromes/data/modal/getUserDetails.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/utils.dart';

import '../../../data/modal/deleteAccountDataModel.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    print("Loading ====> $_isLoading");
  }

  GetUserDetails _getUserDetails = GetUserDetails();

  GetUserDetails get getUserDetails => _getUserDetails;

  Future<GetUserDetails> getUserDetail(bool isSecure) async {
    setIsLoading(true);
    try {
      final apiService = NetworkApiServices();
      final response = await apiService.getGetApiResponse(isSecure,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getUserDetails}?userid=${box.read("cust_id_raipurHomes")}");
      print("user details ===> $response");
      _getUserDetails = GetUserDetails.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _getUserDetails;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetUserDetails> updateUserDetails(
    bool isSecure,
    dynamic data,
  ) async {
    try {
      final apiService = NetworkApiServices();
      final response = await apiService.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.updateUserDetails, data);
      _getUserDetails = GetUserDetails.fromJson(response);
      return _getUserDetails;
    } catch (e) {
      return Utils.toastMessage(
          InvalidInputExceptions("").toString(), errorColor);
    } finally {
      notifyListeners();
    }
  }

  Future<GetUserDetails> updateUserPhoto(
    bool isSecure,
    dynamic data,
    String fieldName,
    String imagePath,
  ) async {
    try {
      final apiService = NetworkApiServices();

      final response = await apiService.postimage(
          false,
          AppUrl.baseUrl + AppUrl.authEndPoints.updateUserDetails,
          data,
          fieldName,
          imagePath);
      _getUserDetails = GetUserDetails.fromJson(response);
      return _getUserDetails;
    } catch (e) {
      return Utils.toastMessage(
          InvalidInputExceptions("").toString(), errorColor);
    } finally {
      notifyListeners();
    }
  }

  DeleteAccountDataModel _accountDeleteDataModel = DeleteAccountDataModel();

  DeleteAccountDataModel get accountDeleteDataModel => _accountDeleteDataModel;

  Future<DeleteAccountDataModel> deleteMyAccount() async {
    try {
      final response = await NetworkApiServices().getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.deletePostProperty}/${box.read("cust_id_raipurHomes")}");
      _accountDeleteDataModel = DeleteAccountDataModel.fromJson(response);
      notifyListeners();
      return _accountDeleteDataModel;
    } catch (e) {
      rethrow;
    }
  }
}
