import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/notificationDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:provider/provider.dart';

class NotificationViewModel extends ChangeNotifier {
  final _apiService = NetworkApiServices();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  NotificationDataModel _notificationDataModel = NotificationDataModel();

  NotificationDataModel get notificationDataModel => _notificationDataModel;

  Future<NotificationDataModel> getNotification() async {
    _isLoading = true;
    try {
      final response = await _apiService.getGetApiResponse(false,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.getNotifications}?userid=${box.read("cust_id_raipurHomes")}");
      _notificationDataModel = NotificationDataModel.fromJson(response);
      _isLoading = false;
      notifyListeners();
      return _notificationDataModel;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
