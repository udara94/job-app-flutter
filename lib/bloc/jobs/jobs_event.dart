import 'package:equatable/equatable.dart';
import 'package:job_app/models/job.dart';

abstract class JobsEvent extends Equatable {}

class GetJobs extends JobsEvent {
  final int? limit;
  final Job? lastJob;
  final Job? startJob;

  GetJobs(this.limit, this.lastJob, this.startJob);

  @override
  List<Object?> get props => [];
}
