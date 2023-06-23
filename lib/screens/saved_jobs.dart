import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/widgets/custom_app_bar.dart';
import 'package:job_app/widgets/navigation_drawer.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({Key? key}) : super(key: key);

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      body:  const Text(
        "Saved jobs page",
        style: TextStyle(fontSize: 20),
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }
}
