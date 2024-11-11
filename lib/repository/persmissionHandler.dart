import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  // Request camera permission
  Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return _handlePermissionStatus(status);
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return _handlePermissionStatus(status);
  }

  // Request microphone/audio permission
  Future<bool> requestAudioPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    return _handlePermissionStatus(status);
  }

  // Request storage permission (gallery access)
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return _handlePermissionStatus(status);
  }

  // Request all permissions
  Future<bool> requestAllPermissions() async {
    bool cameraGranted = await requestCameraPermission();
    bool locationGranted = await requestLocationPermission();
    bool audioGranted = await requestAudioPermission();
    bool storageGranted = await requestStoragePermission();

    // Return true only if all permissions are granted
    return cameraGranted && locationGranted && audioGranted && storageGranted;
  }

  // Handle permission status
  Future<bool> _handlePermissionStatus(PermissionStatus status) async {
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Re-request permission if it is denied
      print('Permission denied. Requesting again...');
      return false; // Handle by re-requesting in `requestAllPermissions`
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, take user to app settings.
      print('Permission permanently denied. Opening app settings...');
      // await openAppSettings();
      return false;
    }
    return false;
  }
}
