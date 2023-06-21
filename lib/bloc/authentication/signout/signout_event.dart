import 'package:equatable/equatable.dart';

abstract class SignOutEvent extends Equatable {}

class SignOutUser extends SignOutEvent {
  @override
  List<Object?> get props => [];

}