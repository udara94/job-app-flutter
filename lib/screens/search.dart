import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/bloc/jobs/filter_job_bloc.dart';
import 'package:job_app/bloc/jobs/filter_job_event.dart';
import 'package:job_app/bloc/jobs/filter_jobs_state.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/utils/common.dart';

import '../models/job.dart';
import '../resources/colors.dart';
import '../resources/images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.keyWord}) : super(key: key);
  final String keyWord;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Image.asset(ImagesRepo.backIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: CommonUtils.getDeviceHeight(context) -
              appBarHeight -
              statusBarHeight,
          width: CommonUtils.getDeviceWidth(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.keyWord,
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
                const Text(
                  Const.jobOpportunities,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
                BlocProvider<FilterJobBloc>(
                  create: (BuildContext context) => FilterJobBloc(),
                  child: BlocBuilder<FilterJobBloc, FilterJobState>(
                    builder: (BuildContext context, FilterJobState state) {
                      if (state is FilterEmpty) {
                        BlocProvider.of<FilterJobBloc>(context)
                            .add(FilterJobs(widget.keyWord));
                      } else if (state is FilterInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilterCompleted) {
                        return buildFilteredJobList(
                            context, state.filteredJobList);
                      } else if (state is FilterError) {}
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilteredJobList(BuildContext context, List<Job> filteredJobList) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredJobList.length,
          itemBuilder: (BuildContext context, int index) {
            Job item = filteredJobList[index];
            return Container(
              width: CommonUtils.getDeviceWidth(context),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
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
                    child: item.employerLogo != null && item.employerLogo != ""
                        ? FadeInImage.assetNetwork(
                            height: 50,
                            width: 50,
                            placeholder: ImagesRepo.appLogo,
                            image: item.employerLogo!,
                            imageErrorBuilder: (context, error, stackTrace) {
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
            );
          },
        ),
      ),
    );
  }
}
