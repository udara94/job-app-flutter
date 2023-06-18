import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.btnText,
      required this.onTap,
      this.backgroundColor,
      this.borderRadius,
      this.verticalPadding,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.textSize,
      this.textColor})
      : super(key: key);
  final Color? backgroundColor;
  final double? borderRadius;
  final double? verticalPadding;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final String btnText;
  final double? textSize;
  final Color? textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      size: iconSize,
                      color: iconColor,
                    )
                  : const SizedBox(),
              icon != null
                  ? const SizedBox(
                      width: 5,
                    )
                  : const SizedBox(),
              Text(
                btnText,
                style: TextStyle(
                    fontSize: textSize,
                    color: textColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
