import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/user/user_bloc.dart';
import 'package:job_app/bloc/authentication/user/user_event.dart';
import 'package:job_app/bloc/authentication/user/user_state.dart';
import 'package:job_app/models/navigation.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/screens/login.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/utils/common.dart';
import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return BlocProvider<UserAuthBloc>(
      create: (BuildContext context) => UserAuthBloc(),
      child: BlocBuilder<UserAuthBloc, UserAuthState>(
        builder: (BuildContext context, UserAuthState state) {
          if (state is UserAuthEmpty) {
            BlocProvider.of<UserAuthBloc>(context)
                .add(CheckUserAuthentication());
          }else if(state is UserAuthValid){
            Future.delayed(const Duration(seconds: 3),(){
              CommonUtils.setUserDetails(context);
              moveToHomePage(context);
            });
          }else if(state is UserAuthInvalid){
            Future.delayed(const Duration(seconds: 3),(){
              moveToLoginPage(context);
            });
          }else if(state is UserAuthError){
            if(kDebugMode){
              print("Error in firebase authentication");
            }
          }
          return Scaffold(
            backgroundColor: theme.bgColors.primary,
            body: Center(
                child: Container(
              width: CommonUtils.getDeviceWidth(context) * 0.7,
              height: CommonUtils.getDeviceWidth(context) * 0.7,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(ImagesRepo.appLogo),
                fit: BoxFit.contain,
              )),
            )),
          );
        },
      ),
    );
  }

  void moveToLoginPage(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.login);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void moveToHomePage(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.home);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
