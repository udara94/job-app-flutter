import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_event.dart';
import 'package:job_app/bloc/jobs/jobs_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';

class PopularJobsComponent extends StatelessWidget {
  const PopularJobsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobsBloc>(
      create: (BuildContext context)=> JobsBloc(),
      child: BlocBuilder<JobsBloc, JobState>(
        builder: (BuildContext context, JobState state){
          if(state is JobsEmpty){
            BlocProvider.of<JobsBloc>(context).add(GetJobs());
          }else if(state is JobsInProgress){
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      Const.popularJobs,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 20),
                    ),
                    Text(Const.seeAll,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightAsh,
                            fontSize: 16))
                  ],
                ),
                const CircularProgressIndicator()
              ],
            );
          }else if(state is JobsCompleted){
            print(state.jobList);
          }else if(state is JobsError){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      Const.popularJobs,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 20),
                    ),
                    Text(Const.seeAll,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightAsh,
                            fontSize: 16))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(Const.loadingError),
                )
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    Const.popularJobs,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 20),
                  ),
                  Text(Const.seeAll,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightAsh,
                          fontSize: 16))
                ],
              ),
            ],
          );
        },

      ),
    );
  }
}
