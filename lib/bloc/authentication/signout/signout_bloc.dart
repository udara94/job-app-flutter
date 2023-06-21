import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/authentication/signout/signout_event.dart';
import 'package:job_app/bloc/authentication/signout/signout_state.dart';
import 'package:job_app/services/firebase_service.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState>{
  final FirebaseService _firebaseService = FirebaseService();

  SignOutBloc(): super(SignOutEmpty()){
    on<SignOutUser>((event, emit) async {
      try{
        emit(SignOutInProgress());
        await _firebaseService.signOut();
        emit(SignOutCompleted());
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(SignOutError());
      }
    });
  }
}