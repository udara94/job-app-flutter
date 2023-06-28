import 'package:equatable/equatable.dart';

import '../../models/job.dart';

class JobState extends Equatable {
  @override
  List<Object?> get props => [];

}

class JobsEmpty extends JobState {}

class JobsInProgress extends JobState {}

class JobsCompleted extends JobState {
  final List<Job> jobList;
  JobsCompleted(this.jobList);
}

class JobsError extends JobState {
  final String error;
  JobsError(this.error);
}