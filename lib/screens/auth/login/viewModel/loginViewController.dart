import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/SentOtpResponseModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class LoginViewController extends ChangeNotifier {
  SentOtpResponseModel _sentOtpResponseModel = SentOtpResponseModel();
  SentOtpResponseModel get sentOtpResponseModel => _sentOtpResponseModel;

  Future<SentOtpResponseModel> loginWithNumber(var data) async {
    try {
      final apiServices = NetworkApiServices();
      final response = await apiServices.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.login, data);
      _sentOtpResponseModel = SentOtpResponseModel.fromJson(response);
      notifyListeners();
      return _sentOtpResponseModel;
    } catch (e) {
      rethrow;
    }
  }
}
