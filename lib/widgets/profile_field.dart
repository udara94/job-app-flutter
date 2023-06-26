import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';

class ProfileField extends StatelessWidget {
  const ProfileField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.isEnabled,
      required this.type,})
      : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final bool isEnabled;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        keyboardType: type,
        enabled: isEnabled,
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            hintText:  hintText,
            labelText: hintText,
            labelStyle: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.normal),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5))),
        style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
