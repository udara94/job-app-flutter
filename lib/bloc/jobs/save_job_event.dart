import 'package:equatable/equatable.dart';
import 'package:job_app/models/job.dart';

abstract class SaveJobEvents extends Equatable {}

class GetSavedJobs extends SaveJobEvents {
  @override
  List<Object?> get props => [];

}

class SaveJob extends SaveJobEvents {
  final Job job;
  SaveJob(this.job);

  @override
  List<Object?> get props => [];

}

class IsJobSaved extends SaveJobEvents{
  final String jobId;
  IsJobSaved(this.jobId);

  @override
  List<Object?> get props => [];
}