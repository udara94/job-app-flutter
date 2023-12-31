import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_app/bloc/authentication/signup/signup_bloc.dart';
import 'package:job_app/bloc/authentication/signup/signup_event.dart';
import 'package:job_app/bloc/authentication/signup/signup_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/custom_button.dart';
import 'package:job_app/widgets/custom_text_form_feild.dart';
import 'package:provider/provider.dart';

import '../models/navigation.dart';
import '../models/user.dart';
import '../provider/navigation_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (BuildContext context, SignUpState state){
          return BlocListener<SignUpBloc, SignUpState>(
            listener: (BuildContext context, SignUpState state){
              if(state is SignUpProgress){
                CommonUtils.showLoading();
              }
              else if(state is SignUpCompleted){
                EasyLoading.dismiss();
                Navigator.pop(context);
                WidgetsBinding.instance!
                    .addPostFrameCallback((timeStamp) {
                  CommonUtils.setUserDetails(context);
                  switchToHome(context);
                });
              }else if(state is SignUpError){
                EasyLoading.dismiss();
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
                          maxHeight: CommonUtils.getDeviceHeight(context),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: CustomTextFormField(
                                      isSecure: false,
                                      onChanged: () {
                                        validateForm();
                                      },
                                      hintTextVal: Const.firstName,
                                      keyboardType: TextInputType.name,
                                      controller: _firstNameController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: CustomTextFormField(
                                      isSecure: false,
                                      onChanged: () {
                                        validateForm();
                                      },
                                      hintTextVal: Const.lastName,
                                      keyboardType: TextInputType.name,
                                      controller: _lastNameController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: CustomTextFormField(
                                      isSecure: false,
                                      onChanged: () {
                                        validateForm();
                                      },
                                      hintTextVal: Const.email,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: CustomTextFormField(
                                      isSecure: false,
                                      onChanged: () {
                                        validateForm();
                                      },
                                      hintTextVal: Const.mobile,
                                      keyboardType: TextInputType.phone,
                                      controller: _mobileController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: CustomTextFormField(
                                      isSecure: true,
                                      onChanged: () {
                                        validateForm();
                                      },
                                      hintTextVal: Const.password,
                                      keyboardType: TextInputType.text,
                                      controller: _passwordController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: CustomButton(
                                      btnText: Const.signUp,
                                      onTap: () {
                                        _isButtonEnable ? signUpUser(context):{};
                                      },
                                      borderRadius: 15,
                                      verticalPadding: 10,
                                      textColor: theme.commonColors.primary,
                                      textSize: 16,
                                      backgroundColor: theme.buttonColors.primary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:  Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    Const.alreadyHaveAccount,
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(color: theme.textColors.primary, offset: Offset(0, -1))
                                        ],
                                        fontWeight: FontWeight.bold,
                                        color: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        decorationColor: theme.textColors.primary,
                                        decorationThickness: 2),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
            ),
          );
        },
      ),
    );
  }

  void signUpUser(BuildContext context)async{
    UserProfile user = UserProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        password: _passwordController.text,
      imageUrl: ""
    );
    BlocProvider.of<SignUpBloc>(context).add(SignUpUser(user));
  }
  void validateForm() {
    if (_firstNameController.text != "" &&
        _lastNameController.text != "" &&
        _emailController.text != "" &&
        _mobileController.text != "" &&
        _passwordController.text != "") {
      setState(() {
        _isButtonEnable = true;
      });
    } else {
      setState(() {
        _isButtonEnable = false;
      });
    }
  }
  void switchToHome(BuildContext context){
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
    //       (Route<dynamic> route) => false,
    // );
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.home);
  }
}
