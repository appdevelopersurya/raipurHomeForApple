import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

import '../../../../data/modal/SentOtpResponseModel.dart';

class OTPViewController extends ChangeNotifier {
  bool _isCorrect = true;
  bool get isCorrect => _isCorrect;

  setIsCorrect(bool value) {
    _isCorrect = isCorrect;
    notifyListeners();
  }

  SentOtpResponseModel _sentOtpResponseModel = SentOtpResponseModel();
  SentOtpResponseModel get sentOtpResponseModel => _sentOtpResponseModel;

  Future<SentOtpResponseModel> verifyOtp(var data) async {
    try {
      final apiServices = NetworkApiServices();
      final response = await apiServices.getPostApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.otp, data);
      _sentOtpResponseModel = SentOtpResponseModel.fromJson(response);
      notifyListeners();
      return _sentOtpResponseModel;
    } catch (e) {
      // Utils.toastMessage("Invalid OTP", errorColor);
      return _sentOtpResponseModel;
    }
  }
}
