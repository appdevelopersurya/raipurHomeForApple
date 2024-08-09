import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/ContactUsDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class SupportViewModel extends ChangeNotifier {
  final apiService = NetworkApiServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ContactUsDataModel _contactUsDataModel = ContactUsDataModel();
  ContactUsDataModel get contactUsDataModel => _contactUsDataModel;

  Future<ContactUsDataModel> getContactDetails() async {
    try {
      final response = await apiService.getGetApiResponse(
          false, AppUrl.baseUrl + AppUrl.authEndPoints.getContactus);
      _contactUsDataModel = ContactUsDataModel.fromJson(response);
      notifyListeners();
      return _contactUsDataModel;
    } catch (e) {
      rethrow;
    }
  }
}
