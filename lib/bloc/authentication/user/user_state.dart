
import 'package:equatable/equatable.dart';

class UserAuthState extends Equatable{
  @override
  List<Object?> get props => [];

}

class UserAuthEmpty extends UserAuthState {}

class UserAuthValid extends UserAuthState {}

class UserAuthInvalid extends UserAuthState {}

class UserAuthError extends UserAuthState {}

