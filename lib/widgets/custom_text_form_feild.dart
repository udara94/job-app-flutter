import 'package:flutter/material.dart';
import 'package:job_app/utils/common.dart';

import '../resources/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintTextVal,
    this.description,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.suffixIconColor,
    this.keyboardType,
    required this.isSecure,
  }) : super(key: key);
  final TextEditingController? controller;
  final Function? onChanged;
  final String? hintTextVal;
  final String? description;
  final bool isSecure;
  final IconData? suffixIcon;
  final Function? onSuffixIconTap;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration:  BoxDecoration(
              color: theme.bgColors.primary,
              borderRadius:  BorderRadius.circular(10.0),
              boxShadow:  [
                BoxShadow(
                  offset: const Offset(1, 1),
                    color: theme.uiColors.disabled,
                    blurRadius: 4.0,
                    spreadRadius: 0.4)
              ]),

          child: TextFormField(
            onChanged: (val) {
              if (onChanged != null) {
                onChanged!();
              }
            },
            keyboardType: keyboardType,
            obscureText: isSecure,
            controller: controller,
            style: TextStyle(color: theme.textColors.primary),
            decoration: InputDecoration(

                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: InputBorder.none,
                hintText: hintTextVal,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: theme.textColors.label,)),
          ),
        ),
      ],
    );
  }
}
