import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/provider/navigation_provider.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/utils/common.dart';
import 'package:provider/provider.dart';

import '../models/navigation.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final UserProfile? user = CommonUtils.getUser(context);
    final FirebaseService _firebaseservice = FirebaseService();
    return Drawer(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: CommonUtils.getDeviceHeight(context)),
          child: Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    user != null && user.imageUrl != null && user.imageUrl != ""
                        ? CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(user.imageUrl!))
                        : const CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage(ImagesRepo.defaultProfile)),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        user != null
                            ? "${user.firstName} ${user.lastName}"
                            : "",
                        style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildMenuItem(context,
                        title: "Home", item: NavigationItem.home),
                    buildMenuItem(context,
                        title: "Saved Jobs", item: NavigationItem.saveJobs),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: SwitchListTile(
                          title: Text("Dark Theme"),
                          value: false,
                          onChanged: (bool value) {},
                        ))
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        title: const Text("logout"),
                        onTap: () {
                          _firebaseservice.signOut();
                          switchToLoginPage(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required String title, required NavigationItem item}) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          selected: isSelected,
          selectedTileColor: AppColors.primary,
          selectedColor: AppColors.white,
          title: Text(title),
          onTap: () => selectItem(context, item),
        ),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }

  void switchToLoginPage(BuildContext context){
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.login);
  }
}
