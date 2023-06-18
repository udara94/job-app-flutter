import 'package:equatable/equatable.dart';

abstract class UserAuthEvent extends Equatable {}

class CheckUserAuthentication extends UserAuthEvent {
  @override
  List<Object?> get props => [];

}

