import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/custom_button.dart';
import 'package:job_app/widgets/custom_text_form_feild.dart';

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
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: CommonUtils.getDeviceHeight(context)),

              //height: CommonUtils.getDeviceHeight(context),
              //margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Stack(
                  children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: CommonUtils.getDeviceWidth(context) * 0.5,
                        height: CommonUtils.getDeviceWidth(context) * 0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagesRepo.appLogo),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomTextFormField(
                          isSecure: false,
                          onChanged: () {},
                          controller: _emailController,
                          hintTextVal: Const.email,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomTextFormField(
                          isSecure: true,
                          onChanged: () {},
                          controller: _passwordController,
                          hintTextVal: Const.password,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: CustomButton(
                          btnText: Const.login,
                          onTap: () {},
                          borderRadius: 15,
                          verticalPadding: 10,
                          textColor: AppColors.white,
                          textSize: 16,
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Text(
                      Const.dontHaveAccount,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: AppColors.primary,
                            offset: Offset(0, -1)
                          )
                        ],
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                        decorationThickness: 2
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Text(
                    //   "Forgot Password?",
                    //   style: TextStyle(
                    //     shadows: [
                    //       Shadow(
                    //           color: Colors.red,
                    //           offset: Offset(0, -5))
                    //     ],
                    //     color: Colors.black,
                    //     decoration:
                    //     TextDecoration.underline,
                    //     decorationColor: Colors.blue,
                    //     decorationThickness: 4,
                    //     decorationStyle:
                    //     TextDecorationStyle.dashed,
                    //   ),
                    // )
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
