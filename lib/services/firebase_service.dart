import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:job_app/models/job.dart';

import '../models/user.dart';

class FirebaseService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference jobRef =
      FirebaseFirestore.instance.collection("Jobs");

  Future<String?> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  //create a new user account
  Future<String?> createAccount(UserProfile userProfile) async {
    try {
      final User? user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userProfile.email,
        password: userProfile.password,
      ))
              .user;
      if (user != null) {
        await userRef.doc(user.uid).set(userProfile.toMap());
        return null;
      } else {
        return 'error in sign up';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserProfile> getUserProfile() async {
    DocumentSnapshot user = await userRef.doc(getUserId()).get();
    UserProfile profile = UserProfile.fromDocument(user);
    return profile;
  }

  Future<List<Job>> getPopularJobs() async {
    List<Job> jobList = [];
    QuerySnapshot querySnapshot = await jobRef.limit(10).get();
    for(var docSnapshot in querySnapshot.docs){
      jobList.add(Job.fromDocument(docSnapshot));
    }
    return jobList;
  }

  Future<void> updateProfile(UserProfile profile) async {
    await userRef.doc(getUserId()).update({
      "firstName": profile.firstName,
      "lastName": profile.lastName,
      "email": profile.email,
      "mobile": profile.mobile,
    });
  }

  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }
}
