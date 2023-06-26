import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/profile_field.dart';

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

  @override
  void initState() {
    firstNameController.text = widget.userProfile.firstName;
    lastNameController.text = widget.userProfile.lastName;
    emailController.text = widget.userProfile.email;
    mobileController.text = widget.userProfile.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final UserProfile user = widget.userProfile;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Image.asset(ImagesRepo.backIcon),
            onPressed: () {
              Navigator.pop(context);
            },
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
                                    ? Container(
                                        color: AppColors.orange,
                                        child: Stack(children: [
                                          FadeInImage.assetNetwork(
                                            placeholder:
                                                ImagesRepo.defaultProfile,
                                            image: user.imageUrl!,
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
                                      )
                                    : FadeInImage.assetNetwork(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                            color: AppColors.primary,
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
                    textColor: AppColors.white,
                    textSize: 16,
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
