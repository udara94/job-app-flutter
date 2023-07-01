import 'package:equatable/equatable.dart';

import '../../models/job.dart';

class SaveJobState extends Equatable {
  @override
  List<Object?> get props => [];

}

class FetchSaveJobsEmpty extends SaveJobState {}

class FetchSaveJobsInProgress extends SaveJobState {}

class FetchSaveJobsCompleted extends SaveJobState {
  final List<Job> savedJobList;
  FetchSaveJobsCompleted(this.savedJobList);
}

class FetchSaveJobsError extends SaveJobState {
  final String error;
  FetchSaveJobsError(this.error);
}


//save job
class SaveJobEmpty extends SaveJobState {}

class SaveJobInProgress extends SaveJobState {}

class SaveJobCompleted extends SaveJobState {}

class SaveJobError extends SaveJobState {
  final String error;
  SaveJobError(this.error);
}

//check job is saved
class IsSaveJobEmpty extends SaveJobState {}

class IsSaveJobLoading extends SaveJobState {}

class IsSaveJobCompleted extends SaveJobState {
  final bool isSaved;
  IsSaveJobCompleted(this.isSaved);
}

class IsSaveJobError extends SaveJobState {
  final String error;
  IsSaveJobError(this.error);
}