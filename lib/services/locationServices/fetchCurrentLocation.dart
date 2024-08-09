import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  String? location;

  Future<String?> checkPermission() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        return "Location services are disabled";
      }

      var permission = await Geolocator.checkPermission();

      // Request permission if it is denied or denied forever
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Utils.toastMessage("Permission denied!", warningColor);
        permission = await Geolocator.requestPermission();
        print("Permission after requesting: $permission");

        // Recheck the permission status after requesting it
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          location = "Permission Denied";
          print("Permission crash error==> $location");
          return location;
        }
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        print("Permission approved==> $location");
        Utils.toastMessage("Permission Approved!", successColor);

        location = await _getLocation();
        return location;
      }

      return "Unknown permission status";
    } catch (e) {
      print("Permission crash error==> ${e.toString()}");
      // Utils.toastMessage(e.toString(), errorColor);
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
      // Utils.toastMessage(e.toString(), errorColor);
      return e.toString();
    }
  }
}
