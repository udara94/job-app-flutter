import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_event.dart';
import 'package:job_app/bloc/jobs/jobs_state.dart';
import 'package:job_app/services/firebase_service.dart';

import '../../models/job.dart';

class JobsBloc extends Bloc<JobsEvent, JobState>{
  final FirebaseService _firebaseFirestore = FirebaseService();

  JobsBloc(): super(JobsEmpty()){
    on<GetJobs>((event, emit) async{
      try{
        emit(JobsInProgress());
        List<Job> jobList = await _firebaseFirestore.getJobs(event.limit, event.lastJob, event.startJob);
        emit(JobsCompleted(jobList));
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(JobsError(e.toString()));
      }
    });
  }
}