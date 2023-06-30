import 'package:equatable/equatable.dart';

import '../../models/job.dart';

class FilterJobState extends Equatable {
  @override
  List<Object?> get props => [];

}

class FilterEmpty extends FilterJobState {}

class FilterInProgress extends FilterJobState {}

class FilterCompleted extends FilterJobState {
  final List<Job> filteredJobList;
  FilterCompleted(this.filteredJobList);
}

class FilterError extends FilterJobState {
  final String error;
  FilterError(this.error);
}