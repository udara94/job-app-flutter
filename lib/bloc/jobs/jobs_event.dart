import 'package:equatable/equatable.dart';

abstract class JobsEvent extends Equatable {}

class GetJobs extends JobsEvent {
  @override
  List<Object?> get props => [];
}