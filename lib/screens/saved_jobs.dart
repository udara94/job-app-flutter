import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/save_job_event.dart';
import 'package:job_app/bloc/jobs/save_job_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/custom_app_bar.dart';
import 'package:job_app/widgets/navigation_drawer.dart';

import '../bloc/jobs/save_job_bloc.dart';
import '../models/job.dart';
import '../resources/images.dart';
import 'job_details.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({Key? key}) : super(key: key);

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldSaveJobKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldSaveJobKey,
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldSaveJobKey,
        title: Const.savedJobs,
      ),
      body: BlocProvider<SaveJobBloc>(
        create: (BuildContext context) => SaveJobBloc(),
        child: BlocBuilder<SaveJobBloc, SaveJobState>(
          builder: (BuildContext context, SaveJobState state) {
            if (state is FetchSaveJobsEmpty) {
              getSavedJobs(context);
            } else if (state is FetchSaveJobsInProgress) {
              return SizedBox(
                width: CommonUtils.getDeviceWidth(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (state is FetchSaveJobsCompleted) {
              return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: ()async{
                    getSavedJobs(context);
                  },
                  child: buildSavedJobsList(context, state.savedJobList));
            } else if (state is FetchSaveJobsError) {
              return SizedBox(
                width: CommonUtils.getDeviceWidth(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(Const.loadingError),
                  ],
                ),
              );
            }
            return SizedBox(
              width: CommonUtils.getDeviceWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }

  Widget buildSavedJobsList(BuildContext context, List<Job> savedJobList) {
    return SizedBox(
      height: CommonUtils.getDeviceHeight(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: CommonUtils.getDeviceWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: CommonUtils.getDeviceWidth(context) - 40,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: savedJobList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Job item = savedJobList[index];
                      return GestureDetector(
                        onTap: () {
                          moveToJobDetailsScreen(context, item);
                        },
                        child: Container(
                          width: CommonUtils.getDeviceWidth(context),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 2),
                                color: AppColors.lightAsh,
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
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.jobEmploymentType ?? "",
                                      style: const TextStyle(
                                        color: AppColors.lightAsh,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void moveToJobDetailsScreen(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetailScreen(
                  job: job,
                ))).then((value) => {
                  getSavedJobs(context)
    });
  }

  void getSavedJobs(BuildContext context){
    BlocProvider.of<SaveJobBloc>(context).add(GetSavedJobs());
  }
}
