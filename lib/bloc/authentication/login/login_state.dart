import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  @override
  List<Object?> get props => [];

}

class LoginEmpty extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginCompleted extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}