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
    for (var docSnapshot in querySnapshot.docs) {
      jobList.add(Job.fromDocument(docSnapshot));
    }
    return jobList;
  }

  Future<List<Job>> getSavedJobs() async {
    List<Job> savedJobList = [];
    QuerySnapshot querySnapshot =
        await userRef.doc(getUserId()).collection("SavedJobs").get();
    for (var docSnapshot in querySnapshot.docs) {
      savedJobList.add(Job.fromDocument(docSnapshot));
    }
    return savedJobList;
  }

  Future<void> saveJob(Job job) async {
    await userRef
        .doc(getUserId())
        .collection("SavedJobs")
        .doc(job.jobId)
        .set(job.toMap());
  }

  Future<void> removeSavedJob(String jobId) async {
    await userRef.doc(getUserId()).collection("SavedJobs").doc(jobId).delete();
  }

  Future<bool> isJobSaved(String jobId) async {
    DocumentSnapshot snapshot =
        await userRef.doc(getUserId()).collection("SavedJobs").doc(jobId).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Job>> filterJobs(String key) async {
    List<Job> filteredJobs = [];
    // QuerySnapshot querySnapshot = await jobRef
    //     .orderBy("job_title")
    //     .startAt([key]).endAt([key + '\uf8ff']).get();
    QuerySnapshot querySnapshot = await jobRef
        .where("job_title", isGreaterThanOrEqualTo: key)
        .where("job_title", isLessThanOrEqualTo: key + '\uf8ff')
        .orderBy("job_title")
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var docSnapshot in querySnapshot.docs) {
        filteredJobs.add(Job.fromDocument(docSnapshot));
      }
    } else {
      if (kDebugMode) {
        print('No documents found matching the keyword.');
      }
    }
    return filteredJobs;
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
