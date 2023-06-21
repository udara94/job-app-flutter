import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;

  UserProfile(
      {required this.firstName,
        required this.lastName,
        required this.email,
        required this.mobile,
        required this.password});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
        firstName: doc.get('firstName') ?? "",
        lastName: doc.get('lastName') ?? "",
        email: doc.get('email') ?? "",
        mobile: doc.get('mobile') ?? "",
        password: "");
  }

  factory UserProfile.fromJson(json) {
    return UserProfile(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        mobile: json['mobile'],
        password: json['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
    };
  }
}
