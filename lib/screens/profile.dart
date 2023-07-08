import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app/models/image.dart';
import 'package:job_app/models/theme.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/profile_field.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userProfile}) : super(key: key);
  final UserProfile userProfile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  bool isEditMode = false;
  File? image;
  late String imageUrl;

  @override
  void initState() {
    firstNameController.text = widget.userProfile.firstName;
    lastNameController.text = widget.userProfile.lastName;
    emailController.text = widget.userProfile.email;
    mobileController.text = widget.userProfile.mobile;
    imageUrl =
        widget.userProfile.imageUrl != null && widget.userProfile.imageUrl != ""
            ? widget.userProfile.imageUrl!
            : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final UserProfile user = widget.userProfile;
    final theme = CommonUtils.getCustomTheme(context);
    return Scaffold(
      backgroundColor: theme.bgColors.primary,
      appBar: AppBar(
        backgroundColor: theme.bgColors.primary,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
                color: theme.commonColors.primary,
                borderRadius: BorderRadius.circular(6)),
            child: IconButton(
              icon: Image.asset(ImagesRepo.backIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: CommonUtils.getDeviceWidth(context),
              maxHeight: CommonUtils.getDeviceHeight(context) -
                  statusBarHeight -
                  appBarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: user.imageUrl != null && user.imageUrl != ""
                          ? CircleAvatar(
                              radius: 80,
                              child: ClipOval(
                                child: isEditMode
                                    ? GestureDetector(
                                        onTap: () {
                                          showBottomSheetTest(theme);
                                        },
                                        child: Container(
                                          color: theme.bgColors.primary,
                                          child: Stack(children: [
                                            FadeInImage.assetNetwork(
                                              placeholder:
                                                  ImagesRepo.defaultProfile,
                                              image: imageUrl,
                                              fit: BoxFit.cover,
                                              width: 160,
                                              height: 160,
                                            ),
                                            Container(
                                              width: 160,
                                              height: 160,
                                              color: Colors.black.withOpacity(
                                                  0.4), // Adjust the opacity as needed
                                            ),
                                            Center(
                                                child: Image.asset(
                                                    ImagesRepo.camera))
                                          ]),
                                        ),
                                      )
                                    : FadeInImage.assetNetwork(
                                        placeholder: ImagesRepo.defaultProfile,
                                        image: imageUrl,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "${user.firstName} ${user.lastName}",
                        style: TextStyle(
                            color: theme.textColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ProfileField(
                      type: TextInputType.text,
                      isEnabled: isEditMode,
                      hintText: Const.firstName,
                      controller: firstNameController,
                    ),
                    ProfileField(
                      type: TextInputType.text,
                      isEnabled: isEditMode,
                      hintText: Const.lastName,
                      controller: lastNameController,
                    ),
                    ProfileField(
                      type: TextInputType.emailAddress,
                      isEnabled: isEditMode,
                      hintText: Const.email,
                      controller: emailController,
                    ),
                    ProfileField(
                      type: TextInputType.phone,
                      isEnabled: isEditMode,
                      hintText: Const.mobile,
                      controller: mobileController,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    btnText: isEditMode ? Const.saveChanges : Const.editProfile,
                    onTap: () {
                      toggleEditMode(context);
                    },
                    borderRadius: 15,
                    verticalPadding: 10,
                    textColor: theme.commonColors.primary,
                    textSize: 16,
                    backgroundColor: theme.buttonColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetTest(CustomThemeData theme) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Wrap(children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme.drawerColors.primary,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              Const.changeProfile,
                              style: TextStyle(
                                  fontSize: 14, color: theme.textColors.label),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Divider(
                            color: theme.uiColors.disabled,
                          ),
                          ListTile(
                            title: Center(
                                child: Text(
                              Const.useCamera,
                              style: TextStyle(color: theme.textColors.primary),
                            )),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageItem.camera);
                            },
                          ),
                          Divider(
                            color: theme.uiColors.disabled,
                          ),
                          ListTile(
                            title: Center(
                                child: Text(
                              Const.useFile,
                              style: TextStyle(color: theme.textColors.primary),
                            )),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageItem.file);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme.drawerColors.primary,
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Center(
                                child: Text(
                              Const.cancel,
                              style: TextStyle(color: theme.commonColors.error),
                            )),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  Future pickImage(ImageItem imageItem) async {
    try {
      final image = await ImagePicker().pickImage(
          source: imageItem == ImageItem.camera
              ? ImageSource.camera
              : ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      uploadImage();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future<void> uploadImage() async {
    FirebaseService firebaseService = FirebaseService();
    String? uploadedImageUrl = await firebaseService.uploadImage(image!);
    if(uploadedImageUrl != null){
      await firebaseService.updateUserProfileImage(uploadedImageUrl);
      setState(() {
        imageUrl = uploadedImageUrl;
      });
      CommonUtils.setUserDetails(context);
    }
  }

  void toggleEditMode(BuildContext context) {
    if (isEditMode &&
        firstNameController.text != "" &&
        lastNameController.text != "" &&
        mobileController.text != "" &&
        emailController.text != "") {
      //update user on firebase
      UserProfile profile = UserProfile(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          mobile: mobileController.text,
          password: "",
          imageUrl: "");
      FirebaseService firebaseService = FirebaseService();
      firebaseService.updateProfile(profile);
      CommonUtils.setUserDetails(context);
    }
    setState(() {
      isEditMode = !isEditMode;
    });
  }
}
