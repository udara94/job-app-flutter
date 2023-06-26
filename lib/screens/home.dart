import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/widgets/custom_app_bar.dart';
import 'package:job_app/widgets/navigation_drawer.dart';

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
      body: const Text(
        "Home page",
        style: TextStyle(fontSize: 20),
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }
}
