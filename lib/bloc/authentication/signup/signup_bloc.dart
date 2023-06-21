import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/signup/signup_event.dart';
import 'package:job_app/bloc/authentication/signup/signup_state.dart';
import 'package:job_app/services/firebase_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseService _firebaseService = FirebaseService();

  SignUpBloc() : super(SignUpEmpty()) {
    on<SignUpUser>((event, emit) async {
      try {
        emit(SignUpProgress());
        await _firebaseService.createAccount(event.userProfile);
        emit(SignUpCompleted());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(SignUpError(e.toString()));
      }
    });
  }
}
