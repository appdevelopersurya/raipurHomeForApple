import 'package:flutter/material.dart';

class KeyboardUtils {
  static void unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
