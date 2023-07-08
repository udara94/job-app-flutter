import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/provider/navigation_provider.dart';
import 'package:job_app/provider/theme.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/services/shared_preference.dart';
import 'package:job_app/utils/common.dart';
import 'package:provider/provider.dart';

import '../models/navigation.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  bool isDarkMode = false;
  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final UserProfile user = CommonUtils.getUser(context);
    final FirebaseService firebaseService = FirebaseService();
    return Drawer(
      backgroundColor: theme.drawerColors.primary,
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
                    user.imageUrl != null && user.imageUrl != ""
                        ? CircleAvatar(
                            radius: 80,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: ImagesRepo.defaultProfile,
                                image: user.imageUrl!,
                                fit: BoxFit.cover,
                                width: 160,
                                height: 160,
                              ),
                            ),
                            //backgroundImage: NetworkImage(user.imageUrl!)
                          )
                        : const CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage(ImagesRepo.defaultProfile)),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text("${user.firstName} ${user.lastName}",
                        style:  TextStyle(
                            color: theme.textColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                        textAlign: TextAlign.center,
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
                          title:  Text("Dark Theme", style: TextStyle(color: theme.textColors.primary),),
                          value: isDarkMode,
                          onChanged: (bool value) {
                            setState(() {
                              isDarkMode = value;
                            });
                            toggleTheme(context, value);
                          },
                        ))
                  ],
                ),
                Column(
                  children: [
                     Divider(color: theme.drawerColors.secondary,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        title:  Text("logout", style: TextStyle(color: theme.drawerColors.secondary),),
                        onTap: () {
                          firebaseService.signOut();
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
    final theme = CommonUtils.getCustomTheme(context);
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          selected: isSelected,
          selectedTileColor: theme.drawerColors.selected,
          selectedColor: isSelected? theme.drawerColors.selectedText :theme.drawerColors.secondary,
          title: Text(title, style: TextStyle(color: isSelected? theme.drawerColors.selectedText :theme.drawerColors.secondary),),
          onTap: () => selectItem(context, item),
        ),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }

  void switchToLoginPage(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(NavigationItem.login);
  }

  void toggleTheme(BuildContext context, bool isDarkMode){
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    provider.setTheme(isDarkMode);
  }

  void getCurrentTheme()async{
    String status = await SharedPreferenceService.readData('theme');
    setState(() {
      isDarkMode = status == "dark"? true: false;
    });
  }
}
