import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_app/models/navigation.dart';
import 'package:job_app/provider/navigation_provider.dart';
import 'package:job_app/provider/theme.dart';
import 'package:job_app/provider/user.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/resources/fonts.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/screens/login.dart';
import 'package:job_app/screens/saved_jobs.dart';
import 'package:job_app/screens/splash.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_animation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(create:(_)=> NavigationProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_)=> UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_)=> ThemeProvider())
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: Fonts.dmSans,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => buildPages();

  Widget buildPages(){
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationItem;

    switch(navigationItem){
      case NavigationItem.splash:
        return const SplashScreen();
      case NavigationItem.login:
        return const LoginScreen();
      case NavigationItem.home:
        return const HomeScreen();
      case NavigationItem.saveJobs:
        return const SavedJobsScreen();
    }
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.transparent
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.transparent
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..fontSize = 15
    ..customAnimation = CustomAnimation();
}
