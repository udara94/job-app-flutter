import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                    color: AppColors.lightAsh,
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
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: InputBorder.none,
                hintText: hintTextVal,
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal, color: AppColors.primary)),
          ),
        ),
      ],
    );
  }
}
