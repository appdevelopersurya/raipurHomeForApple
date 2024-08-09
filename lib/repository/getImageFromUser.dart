import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class GetImageFromUser extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      print("Picked file details:");
      print("Name: ${pickedFile.name}");
      print("Path: ${pickedFile.path}");
      print("MimeType: ${pickedFile.mimeType}");
      print("Size: ${await pickedFile.length()} bytes");
      print("Last modified: ${await pickedFile.lastModified()}");
      _image = File(pickedFile.path);
      notifyListeners();
      return _image;
    } else {
      return _image;
    }
  }

  removeImage() async {
    _image = null;
    notifyListeners();
  }

  Future<File?> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print("Picked file details:");
      print("Name: ${pickedFile.name}");
      print("Path: ${pickedFile.path}");
      print("MimeType: ${pickedFile.mimeType}");
      print("Size: ${await pickedFile.length()} bytes");
      print("Last modified: ${await pickedFile.lastModified()}");
      _image = File(pickedFile.path);
      notifyListeners();
      return  _image;
    }else {
      return _image;
    }
  }
}
