import 'package:flutter/material.dart';
import 'package:job_app/models/user.dart';
import 'package:job_app/services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  UserProfile _userProfile = UserProfile(
      firstName: "",
      lastName: "",
      email: "",
      mobile: "",
      password: "",
      imageUrl: "");
  final FirebaseService _firebaseService = FirebaseService();

  UserProfile get userProfile => _userProfile;

  Future<void> setUser() async {
    _userProfile = await _firebaseService.getUserProfile();
    notifyListeners();
  }
}
