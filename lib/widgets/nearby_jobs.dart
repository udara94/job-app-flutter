import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_event.dart';
import 'package:job_app/bloc/jobs/jobs_state.dart';
import 'package:job_app/utils/common.dart';

import '../models/job.dart';
import '../resources/colors.dart';
import '../resources/const.dart';
import '../resources/images.dart';
import '../screens/job_details.dart';
import '../screens/see_all.dart';

class NearbyJobsComponent extends StatelessWidget {
  const NearbyJobsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CommonUtils.getCustomTheme(context);
    return BlocProvider<JobsBloc>(
        create: (BuildContext context) => JobsBloc(),
        child: BlocBuilder<JobsBloc, JobState>(
          builder: (BuildContext context, JobState state) {
            if (state is JobsEmpty) {
              BlocProvider.of<JobsBloc>(context).add(GetJobs(10, null, null));
            } else if (state is JobsInProgress) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        Const.nearbyJobs,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.textColors.primary,
                            fontSize: 20),
                      ),
                      Text(Const.seeAll,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.uiColors.disabled,
                              fontSize: 16))
                    ],
                  ),
                  const CircularProgressIndicator()
                ],
              );
            } else if (state is JobsCompleted) {
              return buildNearbyJobList(context, state.jobList);
            } else if (state is JobsError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        Const.nearbyJobs,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.textColors.primary,
                            fontSize: 20),
                      ),
                      Text(Const.seeAll,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.uiColors.disabled,
                              fontSize: 16))
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Const.loadingError, style: TextStyle(color: theme.textColors.primary),),
                  )
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      Const.nearbyJobs,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.textColors.primary,
                          fontSize: 20),
                    ),
                    Text(Const.seeAll,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.uiColors.disabled,
                            fontSize: 16))
                  ],
                ),
              ],
            );
          },
        ));
  }

  Widget buildNearbyJobList(BuildContext context, List<Job> jobList) {
    final theme = CommonUtils.getCustomTheme(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
             Text(
              Const.nearbyJobs,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.textColors.primary,
                fontSize: 20,
              ),
            ),
            GestureDetector(
              onTap: (){
                moveToSeeAllScreen(context, Const.nearbyJobs);
              },
              child:  Text(
                Const.seeAll,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.uiColors.disabled,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
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
                        child:
                            item.employerLogo != null && item.employerLogo != ""
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
                                color: theme.uiColors.disabled,
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

  void moveToSeeAllScreen(BuildContext context, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SeeAllJobsScreen(title: title)));
  }
}
