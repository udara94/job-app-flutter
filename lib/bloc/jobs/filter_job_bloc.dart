import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/filter_job_event.dart';
import 'package:job_app/bloc/jobs/filter_jobs_state.dart';
import 'package:job_app/models/job.dart';
import 'package:job_app/services/firebase_service.dart';

class FilterJobBloc extends Bloc<FilterJobEvent, FilterJobState> {
  final FirebaseService _firebaseService = FirebaseService();

  FilterJobBloc() : super(FilterEmpty()) {
    on<FilterJobs>((event, emit) async {
      try {
        emit(FilterInProgress());
        List<Job> filteredJobList =
            await _firebaseService.filterJobs(event.key);
        emit(FilterCompleted(filteredJobList));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(FilterError(e.toString()));
      }
    });
  }
}
