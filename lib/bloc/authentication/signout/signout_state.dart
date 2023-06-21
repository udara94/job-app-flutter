import 'package:equatable/equatable.dart';

class SignOutState extends Equatable{
  @override
  List<Object?> get props => [];

}

class SignOutEmpty extends SignOutState {}

class SignOutInProgress extends SignOutState {}

class SignOutCompleted extends SignOutState {}

class SignOutError extends SignOutState {}