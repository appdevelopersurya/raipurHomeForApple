import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  String? location;

  Future<String?> checkPermission() async {
    try {
      // Check if location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        Utils.toastMessage("Location services are disabled", warningColor);
        await Geolocator.openLocationSettings();
        return "Location services are disabled";
      }

      // Check the current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      // If permission is denied, request permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Utils.toastMessage("Location permission denied", warningColor);
          return "Permission Denied";
        }
      }

      // If permission is permanently denied, display a message
      if (permission == LocationPermission.deniedForever) {
        Utils.toastMessage(
            "Location permissions are permanently denied, we cannot request permissions.",
            warningColor);
        return "Location permissions are permanently denied";
      }

      // If permission is granted, get the location
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Utils.toastMessage("Permission Approved!", successColor);

        location = await _getLocation();
        print("Permission approved==> $location");
        return location;
      }

      return "Unexpected error occurred";
    } catch (e) {
      print("Permission crash error==> ${e.toString()}");
      Utils.toastMessage("Error: ${e.toString()}", errorColor);
      return e.toString();
    }
  }

  Future<String> _getLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      var coordinates =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print("Placemark====> $placemarks");
      if (placemarks.isNotEmpty) {
        var address = '${placemarks[0].subLocality}, ${placemarks[0].locality}';
        return 'Coordinates: $coordinates\nAddress: $address';
      }
      return 'Coordinates: $coordinates\nAddress: Not available';
    } catch (e) {
      return e.toString();
    }
  }
}
