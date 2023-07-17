import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_app/bloc/jobs/jobs_bloc.dart';
import 'package:job_app/bloc/jobs/jobs_event.dart';
import 'package:job_app/bloc/jobs/jobs_state.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/resources/images.dart';
import 'package:job_app/screens/job_details.dart';
import 'package:job_app/utils/common.dart';

import '../models/job.dart';
import '../screens/see_all.dart';

class PopularJobsComponent extends StatelessWidget {
  const PopularJobsComponent({Key? key}) : super(key: key);

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
            CommonUtils.showLoading();
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      Const.popularJobs,
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
                // const CircularProgressIndicator()
              ],
            );
          } else if (state is JobsCompleted) {
            EasyLoading.dismiss();
            return buildPopularJobList(context, state.jobList);
          } else if (state is JobsError) {
            EasyLoading.dismiss();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Const.popularJobs,
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
                    Const.popularJobs,
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
      ),
    );
  }

  Widget buildPopularJobList(BuildContext context, List<Job> jobList) {
    final theme = CommonUtils.getCustomTheme(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              Const.popularJobs,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.textColors.primary,
                  fontSize: 20),
            ),
            GestureDetector(
              onTap: () {
                moveToSeeAllScreen(context, Const.popularJobs);
              },
              child:  Text(Const.seeAll,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.uiColors.disabled,
                      fontSize: 16)),
            )
          ],
        ),
        SizedBox(
          height: CommonUtils.getDeviceHeight(context) * 0.25,
          // Set the desired height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: jobList.length,
            itemBuilder: (BuildContext context, int index) {
              Job item = jobList[index];
              return GestureDetector(
                onTap: () {
                  moveToJobDetailsScreen(context, item);
                },
                child: Container(
                  width: CommonUtils.getDeviceWidth(context) * 0.6,
                  margin: index == 0
                      ? const EdgeInsets.only(
                          left: 2, top: 8, bottom: 8, right: 0)
                      : const EdgeInsets.all(8),
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
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.lightAsh,
                                borderRadius: BorderRadius.circular(10)),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              jobList[index].employerName ?? "",
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                color: theme.uiColors.disabled,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.jobTitle ?? "",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: theme.textColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.jobCountry ?? "",
                            style:  TextStyle(
                              color: theme.uiColors.disabled,
                              fontSize: 16,
                            ),
                          )
                        ],
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
