import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_app/models/theme.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/provider/theme.dart';
import 'package:job_app/provider/user.dart';
import 'package:job_app/resources/const.dart';
import 'package:provider/provider.dart';

import '../resources/images.dart';

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

  static UserProfile getUser(BuildContext context){
    final provider = Provider.of<UserProvider>(context);
    final user = provider.userProfile;
    return user;
  }

  static CustomThemeData getCustomTheme(BuildContext context){
    final provider = Provider.of<ThemeProvider>(context);
    return provider.customTheme;
  }

  static void showLoading() {
    EasyLoading.show(
        indicator: Container(
          child: Image.asset(
            ImagesRepo.appLogo,
            width: 50,
            height: 50,
          ),
        ),
        status: Const.loading,
        maskType: EasyLoadingMaskType.custom);
  }

}