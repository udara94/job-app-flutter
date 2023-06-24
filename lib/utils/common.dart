import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/provider/user.dart';
import 'package:provider/provider.dart';

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

  static void setUserDetails(BuildContext context){
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.setUser();
  }

  static UserProfile? getUser(BuildContext context){
    final provider = Provider.of<UserProvider>(context);
    final user = provider.userProfile;
    return user;
  }
}