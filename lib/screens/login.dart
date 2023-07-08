import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/login/login_bloc.dart';
import 'package:job_app/bloc/authentication/login/login_event.dart';
import 'package:job_app/bloc/authentication/login/login_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/screens/signup.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/custom_button.dart';
import 'package:job_app/widgets/custom_text_form_feild.dart';
import 'package:provider/provider.dart';

import '../models/navigation.dart';
import '../provider/navigation_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isButtonEnable = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (BuildContext context, LoginState state) {
              if (state is LoginInProgress) {}
              else if (state is LoginCompleted) {
                WidgetsBinding.instance
                    .addPostFrameCallback((timeStamp) {
                  CommonUtils.setUserDetails(context);
                  moveToHomePage(context);
                });
              }
              else if (state is LoginError) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      state.error,
                      style:
                       TextStyle(fontSize: 12, color: theme.commonColors.primary),
                    ),
                    backgroundColor: theme.commonColors.error,
                    duration: const Duration(milliseconds: 2000),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            },
            child: Scaffold(
                backgroundColor: theme.bgColors.primary,
                body: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: CommonUtils.getDeviceHeight(context)),

                      //height: CommonUtils.getDeviceHeight(context),
                      //margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Stack(children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                CommonUtils.getDeviceWidth(context) * 0.5,
                                height:
                                CommonUtils.getDeviceWidth(context) * 0.5,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImagesRepo.appLogo),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20),
                                child: CustomTextFormField(
                                  isSecure: false,
                                  onChanged: () {
                                    validateForm();
                                  },
                                  controller: _emailController,
                                  hintTextVal: Const.email,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20),
                                child: CustomTextFormField(
                                  isSecure: true,
                                  onChanged: () {
                                    validateForm();
                                  },
                                  controller: _passwordController,
                                  hintTextVal: Const.password,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: CustomButton(
                                  btnText: Const.login,
                                  onTap: () {
                                    _isButtonEnable ? signInUser(context) : {};
                                  },
                                  borderRadius: 15,
                                  verticalPadding: 10,
                                  textColor: AppColors.white,
                                  textSize: 16,
                                  backgroundColor: AppColors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            moveToSignUpPage();
                          },
                          child:  Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  Const.dontHaveAccount,
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            color: theme.textColors.primary,
                                            offset: const Offset(0, -1))
                                      ],
                                      fontWeight: FontWeight.bold,
                                      color: Colors.transparent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: theme.textColors.primary,
                                      decorationThickness: 2),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        )
                      ]),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  void validateForm() {
    if (_emailController.text != "" && _passwordController.text != "") {
      setState(() {
        _isButtonEnable = true;
      });
    } else {
      setState(() {
        _isButtonEnable = false;
      });
    }
  }

  void moveToSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  void moveToHomePage(BuildContext context) {
    // Navigator.pushAndRemoveUntil(
    //     context, MaterialPageRoute(builder: (context) => const HomeScreen()),
    //         (Route<dynamic> route) => false,
    // );
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.home);
  }

  void signInUser(BuildContext context) async {
    BlocProvider.of<LoginBloc>(context)
        .add(LoginUser(_emailController.text, _passwordController.text));
  }
}
