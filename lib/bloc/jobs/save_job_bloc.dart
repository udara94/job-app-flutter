
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/save_job_event.dart';
import 'package:job_app/bloc/jobs/save_job_state.dart';
import 'package:job_app/models/job.dart';
import 'package:job_app/services/firebase_service.dart';

class SaveJobBloc extends Bloc<SaveJobEvents, SaveJobState>{
  final FirebaseService _firebaseService= FirebaseService();

  SaveJobBloc(): super(FetchSaveJobsEmpty()){
    on<GetSavedJobs>((event, emit)async{
      try{
        emit(FetchSaveJobsInProgress());
        List<Job> savedJobList = await _firebaseService.getSavedJobs();
        emit(FetchSaveJobsCompleted(savedJobList));
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(FetchSaveJobsError(e.toString()));
      }
    });

    on<SaveJob>((event, emit)async{
      try{
        emit(SaveJobInProgress());
        await _firebaseService.saveJob(event.job);
        emit(SaveJobCompleted());
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(SaveJobError(e.toString()));
      }
    });

    on<IsJobSaved>((event, emit)async{
      try{
        emit(IsSaveJobLoading());
        bool isJobSaved = await _firebaseService.isJobSaved(event.jobId);
        emit(IsSaveJobCompleted(isJobSaved));
      }catch(e){
        if(kDebugMode){
          print(e);
        }
        emit(IsSaveJobError(e.toString()));
      }
    });
  }
}