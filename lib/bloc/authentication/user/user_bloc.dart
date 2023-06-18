import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/user/user_event.dart';
import 'package:job_app/bloc/authentication/user/user_state.dart';
import 'package:job_app/services/firebase_service.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState>{
  final FirebaseService _firebaseService = FirebaseService();

  UserAuthBloc(): super(UserAuthEmpty()){
    on<CheckUserAuthentication>((event, emit) {
      try{
         final currentUser = _firebaseService.firebaseAuth.currentUser;
        if(currentUser != null){
          emit(UserAuthValid());
        }else{
          emit(UserAuthInvalid());
        }
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(UserAuthError());
      }
    });
  }

}