import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/login/login_event.dart';
import 'package:job_app/bloc/authentication/login/login_state.dart';
import 'package:job_app/services/firebase_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseService _firebaseService = FirebaseService();

  LoginBloc() : super(LoginEmpty()) {
    on<LoginUser>((event, emit) async {
      try {
        emit(LoginInProgress());
        String? response =
            await _firebaseService.loginUser(event.email, event.password);
        if(response != null){
          return emit(LoginError(response));
        }
        emit(LoginCompleted());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(LoginError(e.toString()));
      }
    });
  }
}
