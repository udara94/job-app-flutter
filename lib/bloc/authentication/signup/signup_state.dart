import 'package:equatable/equatable.dart';

class SignUpState extends Equatable{
  @override
  List<Object?> get props => [];

}

class SignUpEmpty extends SignUpState {}

class SignUpProgress extends SignUpState {}

class SignUpCompleted extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;
  SignUpError(this.error);
}
