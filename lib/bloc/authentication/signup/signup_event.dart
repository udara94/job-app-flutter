import 'package:equatable/equatable.dart';
import 'package:job_app/models/user.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpUser extends SignUpEvent {
  final UserProfile userProfile;
  SignUpUser(this.userProfile);

  @override
  List<Object?> get props => [];
}