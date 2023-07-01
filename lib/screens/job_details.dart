import 'package:flutter/material.dart';
import 'package:job_app/models/job.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/const.dart';
import 'package:job_app/utils/common.dart';
import 'package:job_app/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/images.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.job;
    return Scaffold(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Image.asset(ImagesRepo.share),
              onPressed: () {
                item.jobApplyLink != null && item.jobApplyLink != ""
                    ? _shareJob(context, item.jobApplyLink!)
                    : {};
              },
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: AppColors.lightAsh,
                            blurRadius: 4.0,
                            spreadRadius: 0.4,
                          )
                        ]),
                    child: item.employerLogo != null && item.employerLogo != ""
                        ? FadeInImage.assetNetwork(
                            height: 100,
                            width: 100,
                            placeholder: ImagesRepo.appLogo,
                            image: item.employerLogo!,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImagesRepo.appLogo,
                                height: 100,
                                width: 100,
                              );
                            },
                          )
                        : Image.asset(
                            ImagesRepo.appLogo,
                            height: 100,
                            width: 100,
                          ),
                  ),
                  Text(
                    item.jobTitle ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.employerName ?? "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "/",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        ImagesRepo.location,
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        item.jobCountry ?? "",
                        style:
                            const TextStyle(fontSize: 16, color: AppColors.ash),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TabBar(
                    onTap: (d) {
                      setState(() {
                        currentIndex = d;
                      });
                    },
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      // Set the color of the selected tab indicator
                      borderRadius: BorderRadius.circular(10),
                    ),
                    unselectedLabelColor: AppColors.lightAsh,
                    controller: _tabController,
                    tabs: const [
                      Tab(text: Const.about),
                      Tab(text: Const.qualification),
                      Tab(text: Const.responsibilities),
                    ],
                  ),
                  currentIndex == 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 8, right: 8, bottom: 100),
                          child: SizedBox(
                            width: CommonUtils.getDeviceWidth(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  Const.aboutJob,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(item.jobDescription ?? "N/A",
                                    textAlign: TextAlign.start),
                              ],
                            ),
                          ),
                        )
                      : currentIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 8, right: 8, bottom: 100),
                              child: SizedBox(
                                width: CommonUtils.getDeviceWidth(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "${Const.qualification}:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    item.jobHighlights != null &&
                                            item.jobHighlights!
                                                    .qualifications !=
                                                null &&
                                            item.jobHighlights!.qualifications!
                                                .isNotEmpty
                                        ? ListView.builder(
                                            itemCount: item.jobHighlights!
                                                .qualifications!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String bullet = "\u2022";
                                              String qualification = item
                                                  .jobHighlights!
                                                  .qualifications![index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                    "$bullet $qualification."),
                                              );
                                            })
                                        : const Text("N/A",
                                            textAlign: TextAlign.start)
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 8, right: 8, bottom: 100),
                              child: SizedBox(
                                width: CommonUtils.getDeviceWidth(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "${Const.responsibilities}:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    item.jobHighlights != null &&
                                            item.jobHighlights!
                                                    .responsibilities !=
                                                null &&
                                            item.jobHighlights!
                                                .responsibilities!.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: item.jobHighlights!
                                                .responsibilities!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String bullet = "\u2022";
                                              String responsibilities = item
                                                  .jobHighlights!
                                                  .responsibilities![index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                    "$bullet $responsibilities."),
                                              );
                                            })
                                        : const Text("N/A",
                                            textAlign: TextAlign.start)
                                  ],
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.orangeCream),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            AppColors.orangeCream, BlendMode.srcIn),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            ImagesRepo.heartOutline,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        btnText: Const.applyJob,
                        onTap: () {
                          item.jobGoogleLink != null && item.jobGoogleLink != ""
                              ? _launchUrl(Uri.parse(item.jobGoogleLink!))
                              : {};
                        },
                        borderRadius: 15,
                        verticalPadding: 15,
                        textColor: AppColors.white,
                        textSize: 16,
                        backgroundColor: AppColors.orangeCream,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _shareJob(BuildContext context, String shareText) {
    Share.share(shareText, subject: Const.applyJob);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
