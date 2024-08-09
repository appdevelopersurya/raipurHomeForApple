abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(bool isSecure, String url);
  Future<dynamic> getPostApiResponse(bool isSecure, String url, dynamic data);
}
