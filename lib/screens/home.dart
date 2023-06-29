import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/fonts.dart';
import 'package:job_app/widgets/custom_app_bar.dart';
import 'package:job_app/widgets/navigation_drawer.dart';
import 'package:job_app/widgets/nearby_jobs.dart';
import 'package:job_app/widgets/popular_jobs.dart';
import 'package:job_app/widgets/welcome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        displayProfile: true,
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: const [
              WelcomeComponent(),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: PopularJobsComponent(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: NearbyJobsComponent(),
              )
            ],
          ),
        ),
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }
}
