import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;
  String? imageUrl;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.password,
      required this.imageUrl});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
        firstName: doc.get('firstName') ?? "",
        lastName: doc.get('lastName') ?? "",
        email: doc.get('email') ?? "",
        mobile: doc.get('mobile') ?? "",
        password: "",
        imageUrl: doc.get('imageUrl') ?? "");
  }

  factory UserProfile.fromJson(json) {
    return UserProfile(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        mobile: json['mobile'],
        password: json['password'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'imageUrl': imageUrl,
    };
  }
}
