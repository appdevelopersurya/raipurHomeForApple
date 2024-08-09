import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/BlogDetailsDataModel.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/blogViewDetails/view/blogViewDetails.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

import '../../../../../data/network/NetworkApiServices.dart';

class BlogDetailsViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
  }

  final apiServices = NetworkApiServices();

  BlogDetailsDataModel _blogDetailsDataModel = BlogDetailsDataModel();

  BlogDetailsDataModel get blogDetailsDataModel => _blogDetailsDataModel;

  Future<BlogDetailsDataModel> getBlogDetails(
      bool isSecure, String blogID) async {
    setIsLoading(true);
    try {
      final response = await apiServices.getGetApiResponse(isSecure,
          "${AppUrl.baseUrl}${AppUrl.authEndPoints.blogViewDetails}/${blogID}");
      print("Blog details====> $response");
      _blogDetailsDataModel = BlogDetailsDataModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _blogDetailsDataModel;
    } catch (e) {
      setIsLoading(false);
      rethrow;
    }
  }
}
