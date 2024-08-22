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

  // Check if all permissions are granted
  Future<bool> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.microphone,
      Permission.storage,
    ].request();

    bool allGranted = true;

    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        allGranted = false;
        _handlePermissionStatus(status);
      }
    });

    // Return true if all permissions are granted
    return allGranted;
  }

  // Check the status of individual permissions
  Future<bool> checkCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  Future<bool> checkLocationPermission() async {
    return await Permission.location.isGranted;
  }

  Future<bool> checkAudioPermission() async {
    return await Permission.microphone.isGranted;
  }

  Future<bool> checkStoragePermission() async {
    return await Permission.storage.isGranted;
  }

  // Handle permission status
  Future<bool> _handlePermissionStatus(PermissionStatus status) async {
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // User denied the permission, you might want to show a message or prompt
      // them to grant it from the settings.
      print('Permission denied. Show a dialog to user or handle accordingly.');
      return false;
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, take user to app settings.
      print('Permission permanently denied. Opening app settings...');
      await openAppSettings();
      return false;
    }
    return false;
  }
}
