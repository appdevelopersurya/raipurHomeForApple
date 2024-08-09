import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/color.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      textColor: buttonTextColor,
      backgroundColor: color,
      fontSize: 14.0,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void flushBarErrorMessage(String title, String message,
      BuildContext context, Color color, IconData icon, Color textColors) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          backgroundColor: color,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),
          titleText: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: textColors),
          ),
          borderRadius: BorderRadius.circular(16.0),
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static snackBar(String message, BuildContext context, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(message,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: buttonTextColor)),
    ));
  }

  static void downloadFile({
    required String url,
    required Function(double) onProgress,
    required Function(String) onDownloadCompleted,
    required BuildContext context,
    Color successColor = Colors.green,
  }) {
    FileDownloader.downloadFile(
      url: url,
      onProgress: (fileName, progress) {
        onProgress(progress);
      },
      onDownloadCompleted: (path) {
        snackBar("Downloaded on this path: $path", context, successColor);
        onDownloadCompleted(path);
      },
    );
  }
}
