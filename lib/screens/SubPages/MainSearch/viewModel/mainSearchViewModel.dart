import 'package:flutter/cupertino.dart';
import 'package:fmraipuromes/constant/appApIKeys.dart';
import 'package:fmraipuromes/services/locationServices/googlePlaceSerachAPIServices.dart';

class MainSearchViewModel extends ChangeNotifier {
  GooglePlacesSearchAPI googlePlacesSearchAPI = GooglePlacesSearchAPI();
  List<dynamic> _listOfLocations = [];
  List<dynamic> get listOfLocations => _listOfLocations;
  onChange(String input) async {
    var data = await googlePlacesSearchAPI.placeSuggestionApi(
        false, AppApiKeys.googleSearchPlaceAPIKey, input);
    _listOfLocations = data["prediction"];
    notifyListeners();
  }
}
