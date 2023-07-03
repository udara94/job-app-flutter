import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/provider/user.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/profile.dart';
import 'package:job_app/utils/common.dart';
import 'package:provider/provider.dart';

import '../resources/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, required this.scaffoldKey, this.title, this.displayProfile})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;
  final bool? displayProfile;

  @override
  Widget build(BuildContext context) {
    final UserProfile user = CommonUtils.getUser(context);
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
        style: const TextStyle(color: AppColors.primary),
      ),
      actions: [
        displayProfile != null && displayProfile!
            ? GestureDetector(
                onTap: () {
                  moveToProfilePage(context, user);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 16, top: 8, bottom: 8),
                  child: user.imageUrl != null &&
                          user.imageUrl != ""
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(user.imageUrl!),
                                  fit: BoxFit.cover),
                              color: AppColors.lightBlue),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightBlue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImagesRepo.defaultProfile,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  void moveToProfilePage(BuildContext context, UserProfile userProfile) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  ProfileScreen(userProfile: userProfile,)));
  }
}
