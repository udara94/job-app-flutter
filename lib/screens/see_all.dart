import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_app/bloc/jobs/jobs_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_state.dart';
import 'package:job_app/services/firebase_service.dart';
import 'package:job_app/widgets/custom_pagination.dart';

import '../bloc/jobs/jobs_event.dart';
import '../models/job.dart';
import '../resources/colors.dart';
import '../resources/const.dart';
import '../resources/images.dart';
import '../utils/common.dart';
import 'job_details.dart';

class SeeAllJobsScreen extends StatefulWidget {
  const SeeAllJobsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SeeAllJobsScreen> createState() => _SeeAllJobsScreenState();
}

class _SeeAllJobsScreenState extends State<SeeAllJobsScreen> {
  FirebaseService firebaseService = FirebaseService();
  int pageNumber = 0;
  bool isMoveForward = true;
  bool allowMoveForward = true;

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.bgColors.primary,
        elevation: 0,
        title: Text(
          widget.title,
          style:  TextStyle(color: theme.textColors.primary),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: theme.commonColors.primary,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: IconButton(
                icon: Image.asset(ImagesRepo.backIcon),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
      backgroundColor: theme.bgColors.primary,
      body: SingleChildScrollView(
        child: BlocProvider<JobsBloc>(
          create: (BuildContext context) => JobsBloc(),
          child: BlocBuilder<JobsBloc, JobState>(
            builder: (BuildContext context, JobState state) {
              if (state is JobsEmpty) {
                BlocProvider.of<JobsBloc>(context).add(GetJobs(10, null, null));
              } else if (state is JobsInProgress) {
                CommonUtils.showLoading();
                return SizedBox(
                  width: CommonUtils.getDeviceWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        //CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              } else if (state is JobsError) {
                EasyLoading.dismiss();
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(Const.loadingError),
                );
              } else if (state is JobsCompleted) {
                EasyLoading.dismiss();
                isMoveForward ? pageNumber++ : pageNumber--;
                state.jobList.length < 10
                    ? allowMoveForward = false
                    : allowMoveForward = true;
                return buildJobList(context, state.jobList);
              }
              return SizedBox(
                width: CommonUtils.getDeviceWidth(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildJobList(BuildContext context, List<Job> jobList) {
    final theme = CommonUtils.getCustomTheme(context);
    return SizedBox(
      width: CommonUtils.getDeviceWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: CommonUtils.getDeviceWidth(context) - 40,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: jobList.length,
              itemBuilder: (BuildContext context, int index) {
                Job item = jobList[index];
                return GestureDetector(
                  onTap: () {
                    moveToJobDetailsScreen(context, item);
                  },
                  child: Container(
                    width: CommonUtils.getDeviceWidth(context) - 40,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: theme.cardColors.card,
                      boxShadow:  [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          color: theme.uiColors.disabled,
                          blurRadius: 4.0,
                          spreadRadius: 0.4,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightAsh,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: item.employerLogo != null &&
                                  item.employerLogo != ""
                              ? FadeInImage.assetNetwork(
                                  height: 50,
                                  width: 50,
                                  placeholder: ImagesRepo.appLogo,
                                  image: item.employerLogo!,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      ImagesRepo.appLogo,
                                      height: 50,
                                      width: 50,
                                    );
                                  },
                                )
                              : Image.asset(
                                  ImagesRepo.appLogo,
                                  height: 50,
                                  width: 50,
                                ),
                        ),
                        const SizedBox(width: 20),
                        // Add some spacing between the logo and text
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.jobTitle ?? "",
                                style:  TextStyle(
                                  color: theme.textColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.jobEmploymentType ?? "",
                                style:  TextStyle(
                                  color: theme.textColors.label,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          CustomPagination(
            goPreviousPage: () {
              isMoveForward = false;
              BlocProvider.of<JobsBloc>(context)
                  .add(GetJobs(10, null, jobList[0]));
            },
            goNextPage: () {
              isMoveForward = true;
              BlocProvider.of<JobsBloc>(context)
                  .add(GetJobs(10, jobList[jobList.length - 1], null));
            },
            pageNumber: pageNumber,
            allowMoveForward: allowMoveForward,
          )
        ],
      ),
    );
  }

  void moveToJobDetailsScreen(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetailScreen(
                  job: job,
                )));
  }
}
