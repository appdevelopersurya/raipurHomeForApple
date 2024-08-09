import 'package:flutter/foundation.dart';
import 'package:fmraipuromes/data/network/NetworkApiServices.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';

class GooglePlacesSearchAPI {
  final apiServices = NetworkApiServices();
  String token = "1234567890";
  Future<dynamic> placeSuggestionApi(
    bool isSecure,
    String apiKey,
    String input,
  ) async {
    try {
      String request =
          "${AppUrl.googlePlaceSearchURL}?input=$input&key=$apiKey&sessiontoken=$token";
      final response = await apiServices.getGetApiResponse(isSecure, request);
      if (kDebugMode) {
        print("map data===> $response");
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
