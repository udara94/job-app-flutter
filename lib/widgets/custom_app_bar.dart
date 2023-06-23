import 'package:flutter/material.dart';
import 'package:job_app/resources/images.dart';

import '../resources/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.scaffoldKey, this.title})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: GestureDetector(
        onTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                ImagesRepo.menuIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        title ?? "",
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightBlue
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                ImagesRepo.defaultProfile,
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
