import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../repository/persmissionHandler.dart';

class LocationService {
  String? location;
  final PermissionHandlerService _permissionHandler =
      PermissionHandlerService();

  Future<String?> checkPermission() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        return "Location services are disabled";
      }

      // Check and request location permission using the permission handler service
      bool isPermissionGranted =
          await _permissionHandler.requestLocationPermission();

      if (isPermissionGranted) {
        print("Permission approved==> $location");
        Utils.toastMessage("Permission Approved!", successColor);

        location = await _getLocation();
        return location;
      } else {
        Utils.toastMessage("Permission denied!", warningColor);
        location = "Permission Denied";
        print("Permission crash error==> $location");
        return location;
      }
    } catch (e) {
      print("Permission crash error==> ${e.toString()}");
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
