import 'package:flutter/material.dart';

class CommonUtils {
  CommonUtils._();

  static double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  /// Hide Keyboard
  static void hideKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}