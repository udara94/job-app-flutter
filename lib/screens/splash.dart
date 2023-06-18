import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/user/user_bloc.dart';
import 'package:job_app/bloc/authentication/user/user_event.dart';
import 'package:job_app/bloc/authentication/user/user_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/screens/login.dart';
import 'package:job_app/utils/common.dart';

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
    return BlocProvider<UserAuthBloc>(
      create: (BuildContext context) => UserAuthBloc(),
      child: BlocBuilder<UserAuthBloc, UserAuthState>(
        builder: (BuildContext context, UserAuthState state) {
          if (state is UserAuthEmpty) {
            BlocProvider.of<UserAuthBloc>(context)
                .add(CheckUserAuthentication());
          }else if(state is UserAuthValid){
            Future.delayed(const Duration(seconds: 3),(){
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
            backgroundColor: AppColors.white,
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void moveToHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
