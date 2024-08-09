import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/data/modal/BlogListDataModel.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class BlogViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
  }

  final apiServices = NetworkApiServices();

  BlogListDataModel _blogListDataModel = BlogListDataModel();

  BlogListDataModel get blogListDataModel => _blogListDataModel;

  Future<BlogListDataModel> getBlogList(bool isSecure) async {
    setIsLoading(true);
    try {
      final response = await apiServices.getGetApiResponse(
          isSecure, AppUrl.baseUrl + AppUrl.authEndPoints.blogView);
      print("Blog list====> $response");
      _blogListDataModel = BlogListDataModel.fromJson(response);
      setIsLoading(false);
      notifyListeners();
      return _blogListDataModel;
    } catch (e) {
      setIsLoading(false);
      rethrow;
    }
  }
}
